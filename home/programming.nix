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

}
