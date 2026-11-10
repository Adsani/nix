{ pkgs, ... }:

{
  programs = {
    fish.enable = true; # must be system-level so it lands in /etc/shells
    steam.enable = true;
    steam.protontricks.enable = true;

    # needed for LazyVim/Mason binaries
    gpu-screen-recorder = {
      enable = true;
      ui.enable = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ stdenv.cc.cc glibc ];
    };
    captive-browser.enable = true;
    captive-browser.interface = "enp0s31f6";
    openvpn3.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };
  nixpkgs.config.allowUnfree = true;

  # Minimal system set; everything else lives in home.nix
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    unzip
  ];
}
