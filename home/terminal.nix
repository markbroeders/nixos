{ config, pkgs, ... }:

{
	programs.kitty = {
		enable = true;
		extraConfig = "background_opacity 0.8";
		font.name = "FiraCode Nerd Font";
		font.size = 12.0;
	};
}
