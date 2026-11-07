{ pkgs, ... }:

{
  users.users.adsani = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "vboxusers" # the old "user-with-access-to-virtualbox" is not a real group
    ];
  };
}
