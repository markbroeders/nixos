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
		../../modules/sound.nix
		../../modules/X11.nix
		../../modules/fonts.nix
		../../modules/office.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable networking
	networking.hostName = "hopper"; # Define your hostname.
	networking.networkmanager.enable = true;
	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# List packages installed in system profile. To search, run:
	# $ nix search wget
		environment.systemPackages = with pkgs; [
	#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	#  wget
		];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
