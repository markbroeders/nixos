{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.init.defaultBranch = "main";
    settings.user = {
      name = "Mark Broeders";
      email = "mail@markbroeders.nl";
    };
    # Use gh's stored token for github.com HTTPS auth instead of falling
    # back to an interactive askpass prompt.
    settings.credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
  };

  # Auto-load per-project nix dev shells (see ~/nixos/templates/python)
  # when cd-ing into a directory with an .envrc, via `direnv allow`.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
