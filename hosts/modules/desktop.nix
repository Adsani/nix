{ pkgs, ... }:

{
  imports = [./umbriel.nix];
  services = {
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
    printing.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole 
    elisa
  ];
}
