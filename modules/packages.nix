{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System tools
    wget
    curl
    tree

    # Editors
    vim
    emacs
    kitty

    # Desktop related programs
    libreoffice
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_US
    spotify
    # obsidian
    zotero
    google-chrome

    # Libraries
    hplip
  ]++ [
    inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
  ];

  # ZSH as shell
  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
