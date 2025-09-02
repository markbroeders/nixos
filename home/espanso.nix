{ config, pkgs, ... }:

{
  services.espanso = {
    enable = true;
    matches = {
      base = {
        matches = [
          {
            trigger = ":now";
            replace = "{{currentdate}} {{currenttime}}";
          }
          {
            trigger = "@@@";
            replace = "mail@markbroeders.nl";
          }
          {
            trigger = "@@@";
            replace = "inbox@markbroeders.nl";
          }
          {
            trigger = "@@@";
            replace = "lorentzlaan@markbroeders.nl";
          }
          {
            trigger = "@@@";
            replace = "mbroeders@gmail.com";
          }
          {
            trigger = "cle";
            replace = "cliënte";
            propagate_case = true;
            word = true;
          }
          {
            trigger = "clt";
            replace = "cliënt";
            propagate_case = true;
            word = true;
          }
        ];
      };
      global_vars = {
        global_vars = [
          {
            name = "currentdate";
            type = "date";
            params = {
              format = "%d/%m/%Y";
            };
          }
          {
            name = "currenttime";
            type = "date";
            params = {
              format = "%R";
            };
          }
        ];
      };
    };
  };
}
