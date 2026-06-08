{ config, pkgs, ... }:
# Variables
let
  dotfiles = "${config.home.homeDirectory}/Nix OS/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    # nvim = "neovim";
  };
in

{
  home.username = "Adsani";
  home.homeDirectory = "/home/Adsani";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    fd
    fzf
    lazygit
    git
    kitty
    mpv
    libreoffice
    eza
    zoxide
    yazi
    fastfetch
    starship
    ripgrep
    nil
    nixpkgs-fmt
    ];

  # Broken
  # xdg.configFile = builtins.mapAttrs (name: subpath:{
  #   source = createSymlink "${dotfiles}/${subpath}";
  #   recursive = true;
  # }) configs;
  # Manual nvim
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "{config.home.homeDirectory}/Nix OS/config/neovim";
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting ''";
      shellAliases = {
        ls = "eza --icons --group-directories-first -1";
        nrs = "sudo nixos-rebuild switch --flake ~/Nix OS#Adsani-NixOS";
      };
      shellAbbrs = {
        ll = "ls -l";
        lla = "ls -la";
        la = "ls -a";
      };
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      extraPackages = with pkgs; [
        lua-language-server
        ansible-language-server
        stylua
      ];
      plugins = with pkgs.vimPlugins; [ LazyVim ];
    };
  };
}
