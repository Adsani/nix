{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # booting stuff ------------------------------------------------------------
  boot = {
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
      };
    efi.canTouchEfiVariables = false;
    };
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "splash" ];
  };
  # End of Booting stuff ------------------------------------------------------------

  # Network stuff ------------------------------------------------------------
  networking = {
    hostName = "Adsani-NixOS"; # Hostname
    networkmanager.enable = true; # Make it false then wifi go bye bye
    # KDE Connect
    firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  # Bluetooth duh
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };
  # End of Network Stuff ------------------------------------------------------------

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  # Virtualization 
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
    virtualbox.host.enable = true;
  };

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.niri.default = [ "gnome" "gtk" ];
  };

  # Beginning services stuff ------------------------------------------------------------
  services = {
    # enable x11
    # xserver.enable = true; 

    # DMS Greeter (greetd)
    displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/Adsani/";
      configFiles = [ "/home/Adsani/.config/DankMaterialShell/settings.json" ];
    };

    # Gnome keyring for Niri
    gnome.gnome-keyring.enable = true;

    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # Touchpad
    libinput.enable = true;

    # Dnscrypt
    dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = [ "cloudflare" "google" "cloudflare-ipv6" "google-ipv6" ];
        listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
        require_dnssec = false;
        require_nolog = true;
        require_nofilter = true;
      };
    }; 
  };
  # End of services stuff

  # Programs stuff ------------------------------------------------------------
  programs = {

    # Window manager
    niri = {
      enable = true;
      useNautilus = true;
    };

    # Shell
    dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      enableSystemMonitoring = true; # dgop
      enableVPN = true;
      enableDynamicTheming = true; # Matugen
      enableAudioWavelength = true; # cava
      enableCalendarEvents = true;
      enableClipboardPaste = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };

    # fih
    fish.enable = true;

    # nix ld for LazyVim
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ 
        stdenv.cc.cc
        glibc
      ];
    };
  };
  # End of Program ------------------------------------------------------------

  nixpkgs.config.permittedInsecurePackages = [ "electron-39.8.10" ];
  # Environment Variables
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Adsani = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" "wheel" "networkmanager" "video" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    btrfs-progs
    efibootmgr
    distrobox
    python3
    wl-clipboard
    xwayland-satellite
    unzip
    wget
    gcc
  ];

  # Fonts
  fonts = {
    packages = with pkgs; [ nerd-fonts.jetbrains-mono noto-fonts noto-fonts-cjk-sans noto-fonts-cjk-serif noto-fonts-color-emoji ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      subpixel = {
        rgba = "none";
        lcdfilter = "none";
      };
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Nix experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Nix seems this thing is important, so please don't change it
  system.stateVersion = "26.05"; # Did you read the comment? No lol
}

