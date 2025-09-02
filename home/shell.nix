{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -all";
      update = "sudo nixos-rebuild switch --flake ~/nixos"; # No need to specify hostnames (I think)
      # Git commands
      gs = "git status";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push -u origin main";
      # System
      # Nixos Flake Update
      nfu = " sudo nixos-rebuild switch --flake /home/mark/nixos#wheeler";
      # Nixos Package Add
      npa = "hx ~/nixos/modules/packages.nix";
    };
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "robbyrussell";
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "\\eOA" ];
      searchDownKey = [ "\\eOB" ];
    };
  };
}
