{ ... }:

{
  imports = [
    ./hardware-configuration.nix # copy yours from /etc/nixos/ here

    ../modules/boot.nix
    ../modules/networking.nix
    ../modules/desktop.nix
    ../modules/audio.nix
    ../modules/graphics-intel.nix
    ../modules/bluetooth.nix
    ../modules/fingerprint.nix
    ../modules/virtualisation.nix
    ../modules/fonts.nix
    ../modules/users.nix
    ../modules/programs.nix
    ../modules/nix.nix
  ];

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  services.openssh.enable = true;
  services.flatpak.enable = true;

  # Do not change after install.
  system.stateVersion = "26.05";
}
