{ pkgs, ... }:

{
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
  };
}
