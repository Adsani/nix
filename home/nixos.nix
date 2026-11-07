{ lib, config, pkgs, ... }:

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
    umbriel = "umbriel";
  };
in

{
  imports = [
    ./package.nix
  ];

  home = {
    username = "adsani";
    homeDirectory = "/home/adsani";
    stateVersion = "26.05";
    packages = with pkgs; [
      fish # Since I use symlink, I only need the binary
      neovim
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
