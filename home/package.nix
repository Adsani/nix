{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # TUI Apps
    neovim
    lazygit
    superfile
    btop

    # CLI Apps
    fd
    fzf
    eza
    zoxide
    fastfetch
    starship
    bat
    ripgrep
    tldr
    figlet

    # Icons Apps
    papirus-icon-theme

    # Others
    nil
    nixpkgs-fmt

    kitty
    goverlay
  ];
  # programs.kdeconnect.enable = true;
  programs = {
    firefox.enable = true;
    mangohud.enable = true;
  };
}
