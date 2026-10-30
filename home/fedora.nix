{ config, pkgs, ... }:

# Variables
let
  dotfiles = "${config.home.homeDirectory}/nix/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    btop = "btop";
    dms = "dms";
    fastfetch = "fastfetch";
    fish = "fih";
    kitty = "kitty";
    lazygit = "lazygit";
    eza = "ls";
    mpv = "mpv";
    nvim = "neovim";
    niri = "niri";
    starship = "prompt";
    superfile = "superfile";
  };
in

{
  imports = [
    ./package.nix
  ];

  home = {
    username = "adsani";
    homeDirectory = "/home/adsani";
    stateVersion = "25.11";
    packages = with pkgs; [
      # home-manager
    ];
  };
  programs.home-manager.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath:{
    source = createSymlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
  xdg.dataFile."icons/Future-cyan-cursors".source = ../config/Future-cyan-cursors;
}
