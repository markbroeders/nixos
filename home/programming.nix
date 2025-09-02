{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig.init.defaultBranch = "main";
    userName = "Mark Broeders";
    userEmail = "mail@markbroeders.nl";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
      };
    };
    extraConfig = ''
      [keys.normal."C-c".o]
      c = ":open ~/.config/"              # Open configuration directory
      n = ":open ~/Documenten/Notes/"     # Open Notes directory
      [keys.normal."C-c"]
      j = ":sh kitty -e python ~/.config/scripts/journal.py"
    '';
  };

  xdg.configFile."helix/languages.toml".text = ''
    [[language]]
    name = "python"
    language-servers = [ "pylsp" ]

    [[language]]
    name = "markdown"
    text-width = 120
    soft-wrap.enable = true
    soft-wrap.wrap-at-text-width = true
    language-servers = [ "marksman", "markdown-oxide" ]
    formatter = { command = 'prettier', args = [
      "--parser",
      "markdown",
      "--prose-wrap",
      "never",
    ]}
  '';
}
