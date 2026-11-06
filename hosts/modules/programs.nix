{ pkgs, ... }:

{
  programs = {
    fish.enable = true; # must be system-level so it lands in /etc/shells

    # needed for LazyVim/Mason binaries
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ stdenv.cc.cc glibc ];
    };
  };

  # Minimal system set; everything else lives in home.nix
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    unzip
  ];
}
