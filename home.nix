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
      # GUI Apps
      helium
      kitty
      mpv
      localsend
      libreoffice
      bitwarden-desktop
      nautilus

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
      adwaita-icon-theme

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
      interactiveShellInit = "set fish_greeting ''\n set -gx XDG_DATA_DIRS $XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
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
