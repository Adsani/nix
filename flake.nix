{
  description = "I Use NixOS BTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Noctalia doesn't recommend adding inputs.nixpkgs.follows for cache hit
    noctalia.url = "github:noctalia-dev/noctalia";
    umbriel.url = "github:noctalia-dev/umbriel";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.Adsani-NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.adsani = import ./home/nixos.nix;
            backupFileExtension = "backup";
          };
        }
      ];
      specialArgs = {
        inherit inputs;
      };
    };

    homeConfigurations."adsani@Adsani-Fedora" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      extraSpecialArgs = {
        inherit inputs;
      };
      modules = [
        ./home/fedora.nix
      ];
    };
  };
}
