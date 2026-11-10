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
    tree
    rustup

    # Icons Apps
    papirus-icon-theme

    # Others
    nil
    nixpkgs-fmt

    kitty
    goverlay
    # (discord.override {
    #   withVencord = true;
    # })
    vesktop
    python3
    zenity
  ];
  # programs.kdeconnect.enable = true;
  programs = {
    # firefox.enable = true;
    mangohud.enable = true;
    uv.enable = true;
  };
}
