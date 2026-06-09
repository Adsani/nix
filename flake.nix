{
  description = "I Use NixOS BTW";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, helium,  ... }@inputs: {
    nixosConfigurations.Adsani-NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [ inputs.helium.overlays.default ];
        }
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.Adsani = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
