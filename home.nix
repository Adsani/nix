{ config, pkgs,  ... }:

# Variables
let
 dotfiles = "${config.home.homeDirectory}/Nix/config";
 createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
 configs = {
   nvim = "neovim";
   fastfetch = "fastfetch";
   fish = "fih";
   eza = "ls";
   starship = "prompt";
   yazi = "yazi";
 };
in

{
  home = {
    username = "Adsani";
    homeDirectory = "/home/Adsani";
    stateVersion = "26.05";
    packages = with pkgs; [
      # GUI Apps
      brave
      kitty
      mpv
      localsend
      libreoffice

      # TUI Apps
      neovim
      lazygit
      yazi

      # CLI Apps
      fd
      flatpak
      fzf
      eza
      zoxide
      fastfetch
      starship
      bat
      ripgrep

      # Icons Apps
      papirus-icon-theme

      # Others
      nil
      nixpkgs-fmt
    ];
  };
  # Home Manager
  services = {
    kdeconnect.enable = true;
  };

  # All Regular config in ./config to symlink to ~/.config
  # IMPORTANT. DON'T USE programs.enable IF THE DEFAULT CONFIG IS NOT DECLARED WITH NIX
 xdg.configFile = builtins.mapAttrs (name: subpath:{
   source = createSymlink "${dotfiles}/${subpath}";
   recursive = true;
 }) configs;
}
