{ pkgs, ... }:

{
  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
    printing.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole # install a terminal in home.nix (kitty/ghostty/etc.)
    elisa
  ];

  xdg.portal.enable = true;
}
