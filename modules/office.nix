{ config, pkgs, ... }:

{
 environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_US
  ];
}
