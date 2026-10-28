{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # TUI Apps
    neovim
    lazygit

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

    # Icons Apps
    papirus-icon-theme

    # Others
    nil
    nixpkgs-fmt
  ];
}
