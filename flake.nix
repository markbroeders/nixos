{
  description = "My NixOS Flake";
  inputs = {
    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      claude-code-nix,
      home-manager,
      ...
    }@inputs:
    {
      templates.python = {
        path = ./templates/python;
        description = "Python project dev shell (nix devShell + direnv venv)";
      };

      nixosConfigurations = {
        wheeler = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };   # <-- add this
          modules = [
            ./hosts/asus
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.mark = import ./home;
            }
          ];
        };
      };
    };
}
