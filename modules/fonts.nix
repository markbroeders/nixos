{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.terminess-ttf
      ];
    fontconfig = {
      enable = true;
      defaultFonts = {
      monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
    serif = [
      "Noto Serif"
      "Source Han Serif"
      ];
    sansSerif = [
      "Noto Sans"
      "Source Han Sans"
      ];
    };
  };
};
}
