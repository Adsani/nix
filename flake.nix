{
  description = "I Use NixOS BTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.Adsani-NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = {};
            useGlobalPkgs = true;
            useUserPackages = true;
            users.Adsani = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
      specialArgs = {
        inherit inputs;
      };
    };
  };
}
