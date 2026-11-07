{ pkgs, ... }:

{
  boot = {
    loader = {
      # Limine replaces GRUB. Windows is chainloaded via extraEntries.
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 10; # keeps the (small) Windows ESP from filling up
        extraEntries = ''
          /Windows
              protocol: efi
              path: uuid(d22fe110-2577-4002-a8a9-65ad63dc4db1):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        style = {
          wallpapers = [];
          interface.branding = "Adsani's Thinkpad T14 G2i Boot Menu";
        };
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "splash" ];
    supportedFilesystems = [ "ntfs" "btrfs" ];
  };

  environment.systemPackages = with pkgs; [ efibootmgr btrfs-progs ];
}
