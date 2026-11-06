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
              path: uuid(REPLACE-WITH-WINDOWS-ESP-PARTUUID):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
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
