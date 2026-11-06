{ ... }:

{
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
    # VirtualBox and libvirt/KVM can conflict; keep only one if you can.
    virtualbox.host.enable = true;
  };
}
