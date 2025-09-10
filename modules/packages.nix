{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System tools
    wget
    curl
    tree

    # Editors
    helix
    kitty

    # Desktop related programs
    wofi
    libreoffice
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_US
    spotify
    obsidian
    zotero

    # Libraries
    hplip

    # Language servers
    nil
    prettier
    python312Full
    python312Packages.pip
    python312Packages.python-lsp-server # pylsp
    marksman # Markdown LSP
    markdown-oxide # Task management in Helix

    python312Packages.tkinter
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
  };

   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "mark" ];
}
