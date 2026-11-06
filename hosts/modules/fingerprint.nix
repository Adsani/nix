{ ... }:

{
  services.fprintd.enable = true;

  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    plasmalogin.fprintAuth = true;
  };
}
