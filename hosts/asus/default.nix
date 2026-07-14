{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/packages.nix
      ../../modules/system.nix
      ../../modules/services.nix
      ../../modules/desktop.nix
      ../../modules/fonts.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mark = {
    isNormalUser = true;
    description = "Mark Broeders";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager.backupFileExtension = "backup";

  # Do not change without reading https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}

