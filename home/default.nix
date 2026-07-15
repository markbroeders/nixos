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
    ./emacs.nix
  ];

  # Add custom config files for Kitty
  # Must be an absolute path string, not a relative Nix path (./config/kitty),
  # otherwise it gets interned into the store at eval time and the symlink
  # points at a frozen copy instead of the live repo file.
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home/config/kitty";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
