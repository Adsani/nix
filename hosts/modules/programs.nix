{ pkgs, ... }:

{
  programs = {
    fish.enable = true; # must be system-level so it lands in /etc/shells
    steam.enable = true;

    # needed for LazyVim/Mason binaries
    gpu-screen-recorder = {
      enable = true;
      ui.enable = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ stdenv.cc.cc glibc ];
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
