{ config, pkgs, ...}:

{
	# Set your time zone.
	time.timeZone = "Europe/Amsterdam";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "nl_NL.UTF-8";
		LC_IDENTIFICATION = "nl_NL.UTF-8";
		LC_MEASUREMENT = "nl_NL.UTF-8";
		LC_MONETARY = "nl_NL.UTF-8";
		LC_NAME = "nl_NL.UTF-8";
		LC_NUMERIC = "nl_NL.UTF-8";
		LC_PAPER = "nl_NL.UTF-8";
		LC_TELEPHONE = "nl_NL.UTF-8";
		LC_TIME = "nl_NL.UTF-8";
	};

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "intl";
	};

	# Configure console keymap
	console.keyMap = "us-acentos";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.mark = {
		isNormalUser = true;
		description = "Mark Broeders";
		extraGroups = [ "networkmanager" "wheel" "input" ];
		packages = with pkgs; [
			firefox
		];
		shell = pkgs.zsh;
	};

	programs.zsh.enable = true;

	# Enable ssh
	# services.openssh = {
	#   enable = true;
	# };

	# Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
	systemd.services."getty@tty1".enable = false;
	systemd.services."autovt@tty1".enable = false;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		powertop
		git
		wget
		curl
		tree

		nodejs
		cmake
		gnumake
		gcc

    	xfce.thunar  # xfce4's file manager
		widevine-cdm

		cifs-utils
	];
  
	# thunar file manager(part of xfce) related options
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
			thunar-volman
	];
	services.gvfs.enable = true; # Mount, trash, and other functionalities
}
