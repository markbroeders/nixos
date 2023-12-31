# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	nix = {
		package = pkgs.nixFlakes;
		extraOptions = ''
			experimental-features = nix-command flakes
			'';
	};

	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix

		../../modules/system.nix
		../../modules/bluetooth.nix
		../../modules/sound.nix
		../../modules/X11.nix
		../../modules/fonts.nix
		../../modules/office.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "wheeler"; # Define your hostname.
	networking.networkmanager.enable = true;

	# Touchpad configuration
	environment.systemPackages = [
		pkgs.libinput-gestures
		pkgs.xdotool
		pkgs.wmctrl
	];

	services.xserver.libinput.touchpad = {
		naturalScrolling = true;
	};


	services.tlp.enable = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
