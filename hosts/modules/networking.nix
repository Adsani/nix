{ ... }:

let
  kdeConnectPorts = [ { from = 1714; to = 1764; } ];
in
{
  networking = {
    hostName = "Adsani-NixOS";
    networkmanager = {
      enable = true;
      dns = "none"; # let dnscrypt-proxy own DNS
    };
    nameservers = [ "127.0.0.1" "::1" ];

    firewall = {
      allowedTCPPortRanges = kdeConnectPorts; # KDE Connect
      allowedUDPPortRanges = kdeConnectPorts;
    };
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      server_names = [ "cloudflare" "google" "cloudflare-ipv6" "google-ipv6" ];
      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      require_dnssec = false;
      require_nolog = true;
      require_nofilter = true;
    };
  };
}
