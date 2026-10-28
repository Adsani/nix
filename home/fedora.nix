{ config, pkgs, ... }:

# Variables
let
  dotfiles = "${config.home.homeDirectory}/nix/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "neovim";
    fastfetch = "fastfetch";
    fish = "fih";
    eza = "ls";
    starship = "prompt";
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
}
