{ config, pkgs, ... }:

{
	# Enable the X11 windowing system
	services.xserver = {
		enable = true;
		displayManager = {
			lightdm.enable = true;
			autoLogin = {
				enable = true;
				user = "mark";
			};
		};
	};

	services.picom.enable = true;

	environment.systemPackages = with pkgs; [
		dmenu
		rofi
		feh
		picom

		brightnessctl
		i3lock

		xdg-desktop-portal-gtk
		xorg.libX11
		xorg.libX11.dev
		xorg.libxcb
		xorg.libXft
		xorg.libXinerama
		xorg.xinit
		xorg.xinput
	];
	
	# Install dwm as window manager
	services.xserver.windowManager.dwm.enable = true;
	nixpkgs.overlays = [
		(self: super: {
		 dwm = super.dwm.overrideAttrs (oldattrs: {
				 src = fetchGit {
				 url = "https://github.com/markbroeders/dwm-mark";
				 rev = "309ce56d29ff91773cd57f3dd873e347348b0a29";
				 };
			});
		})
	];

	services.physlock.enable = true;
	services.physlock.allowAnyUser = true;
	services.xserver.xautolock.enable = true;
	services.xserver.xautolock.locker = "/run/wrappers/bin/physlock";
}

