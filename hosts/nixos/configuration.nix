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
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "splash" ];
    supportedFilesystems = [ "ntfs" "btrfs" ];
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
  i18n.defaultLocale = "en_US.UTF-8";

  # Virtualization 
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
    virtualbox.host.enable = true;
  };

  # Beginning services stuff ------------------------------------------------------------
  services = {
    # plasma
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;

    # Touchpad
    libinput.enable = true;
    printing.enable = true;

    # Fingerprint
    fprintd.enable = true;

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
    flatpak.enable = true;
  # Enable the OpenSSH daemon.
    openssh.enable = true;
  };
  # End of services stuff

  # Security stuff (Fingerprint)
  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    plasmalogin.fprintAuth = true;
  };

  # Programs stuff ------------------------------------------------------------
  programs = {
    fish.enable = true; # So it recognize in /etc/shells
    # App image
    #appimage = {
     # enable = true;
     # binfmt = true;
     # package = pkgs.appimage-run.override {
       # extraPkgs = pkgs: [
        #  pkgs.icu
         # pkgs.libxcrypt-legacy
         # pkgs.python312
         # pkgs.python312Packages.torch
       # ];
     # };
   # };

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

  hardware = {
    intel-gpu-tools.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        level-zero
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    };

    # Bluetooth duh
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };

  # Environment Stuff
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
    ];
  # List packages installed in system profile.
    systemPackages = with pkgs; [
      btrfs-progs
      efibootmgr
      distrobox
      python3
      wl-clipboard
      xwayland-satellite
      unzip
      wget
      gcc
      vim
      git
      btop
      dnsmasq
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Adsani = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ 
      "libvirtd"
      "user-with-access-to-virtualbox"
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };


  # Fonts
  fonts = {
    packages = with pkgs; [ 
      nerd-fonts.jetbrains-mono
      noto-fonts noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
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
  nix = {
    settings.experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Nix seems this thing is important, so please don't change it
  system.stateVersion = "26.05"; # Did you read the comment? No lol
}

