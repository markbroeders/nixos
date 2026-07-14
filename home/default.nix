{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "26.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shell.nix
    ./programming.nix
  ];

  # Add custom config files for Kitty
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/kitty;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
