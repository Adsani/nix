{ config, pkgs,  ... }:
# Variables
let
  dotfiles = "${config.home.homeDirectory}/Nix OS/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "neovim";
    fastfetch = "fastfetch";
    # fish = "fih";
  };
in

{
  home = {
    username = "Adsani";
    homeDirectory = "/home/Adsani";
    stateVersion = "26.05";
    packages = with pkgs; [
      helium
      neovim
      fd
      fzf
      lazygit
      kitty
      mpv
      libreoffice
      eza
      zoxide
      yazi
      localsend
      fastfetch
      starship
      ripgrep
      nil
      nixpkgs-fmt
      bat
      papirus-icon-theme
      adwaita-icon-theme
      # bitwarden-desktop
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

  programs = {
    # neovim = {
    #   enable = true;
    #   viAlias = true;
    #   vimAlias = true;
    #   defaultEditor = true;
    # };
    git = {
      enable = true;
      settings = {
        user.name = "Adsani";
        user.email = "Adsani.ty@proton.me";
      };
    };
    ssh = {
      enable = true;
      # settings = {
      #   addKeysToAgent = "yes";
      # };
      addKeysToAgent = "yes";
    };
    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting ''";
      shellAliases = {
        ls = "eza --icons --group-directories-first -1";
        cat = "bat";
      };
      shellAbbrs = {
        ll = "ls -l";
        lla = "ls -la";
        lsa = "ls -a";
      };
      # function for yazi
      functions.y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
          builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
      '';
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
