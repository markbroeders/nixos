{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shell.nix
    ./programming.nix
    # ./espanso.nix    # TODO: NOT WORKING ATM
  ];

  # Add custom config files for Kitty and Wofi
  home.file = {
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/wofi;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/kitty;
    };
    ".config/moxide" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/moxide;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
