{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userName = "Mark Broeders";
		userEmail = "inbox@markbroeders.nl";
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
	};  

	xdg.configFile.nvim.source = ../dotfiles/nvim;
}
