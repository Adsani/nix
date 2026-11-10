{ pkgs, ... }:

let
  kdeConnectPorts = [ { from = 1714; to = 1764; } ];
in
{
  networking = {
    hostName = "Adsani-NixOS";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved"; 
      plugins = with pkgs; [ networkmanager-openvpn ];
    };

    firewall = {
      allowedTCPPortRanges = kdeConnectPorts; # KDE Connect
      allowedUDPPortRanges = kdeConnectPorts;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "opportunistic";
      DNSSEC = "allow-downgrade";
      FallbackDNS = [ "1.1.1.1" "8.8.8.8" ];
    };
  };
}
