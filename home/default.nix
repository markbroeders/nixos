{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "mark";
	home.homeDirectory = "/home/mark";
	home.stateVersion = "23.05"; # Please read the comment before changing.

		nixpkgs.config.allowUnfree = true;

	imports = [
		./shell.nix
		./development.nix
		./terminal.nix
		./espanso.nix
	];

# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = with pkgs; [
		obsidian
		spotify
	];

	programs.qutebrowser = {
		enable = true;
		searchEngines = {
	  w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
	  aw = "https://wiki.archlinux.org/?search={}";
	  nw = "https://nixos.wiki/index.php?search={}";
	  g = "https://www.google.com/search?hl=en&q={}";
		};
		settings = {
			url.start_pages = https://www.google.com;
			url.default_page = about:blank;
		};
	};

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
	home.file = {
		".dwm/autostart.sh".source = ../dotfiles/autostart.sh;
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
