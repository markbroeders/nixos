{ config, pkgs, ... }:

{

# Enable the X11 windowing system.
	services.xserver.enable = true;

# DWM
	services.xserver.windowManager.dwm.enable = true;

	services.xserver.displayManager = {
		lightdm.enable = true;
		autoLogin = {
			enable = true;
			user = "mark";
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

	nixpkgs.overlays = [
		(self: super: {
		 dwm = super.dwm.overrideAttrs (oldattrs: {
				 src = fetchGit {
				 url = "https://github.com/markbroeders/dwm-mark";
				 rev = "a7b72e939472a4bd46f89dd20f299d358fd7cd40";
				 };
				 });
		 })
	];

	services.physlock.enable = true;
	services.physlock.allowAnyUser = true;
	services.xserver.xautolock.enable = true;
	services.xserver.xautolock.locker = "/run/wrappers/bin/physlock";

	# services.xserver.xautolock.enable = true;
	# services.xserver.xautolock.locker = "${pkgs.i3lock}/bin/i3lock";
}

