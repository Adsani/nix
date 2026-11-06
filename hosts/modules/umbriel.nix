
{ inputs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.umbriel.nixosModules.default
  ];

  programs.umbriel.enable = true; 

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 24;
      keyboard.layout = "us";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  services.libinput.enable = true;
  services.printing.enable = true;

  # Binary caches so Noctalia/Umbriel don't compile locally
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" "https://umbriel.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
    ];
  };
}
