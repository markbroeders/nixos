{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -all";
			update = "sudo nixos-rebuild switch --flake ~/nixos#wheeler";
		};
		enableCompletion = true;
		enableAutosuggestions = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "sudo" ];
			theme = "robbyrussell";
		};
		historySubstringSearch = {
			enable = true;
			searchUpKey = ["\\eOA"];
			searchDownKey = ["\\eOB"];
		};
	};

}
