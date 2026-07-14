{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.init.defaultBranch = "main";
    settings.user = {
      name = "Mark Broeders";
      email = "mail@markbroeders.nl";
    };
  };

  # Auto-load per-project nix dev shells (see ~/nixos/templates/python)
  # when cd-ing into a directory with an .envrc, via `direnv allow`.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
