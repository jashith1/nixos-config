# Generic hardware support (nothing specific to one machine).
{ ... }:

{
  security.rtkit.enable = true; #for improved audio performance

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.initrd.enable = true; #loads amd drivers to initrd, helps early boot visual stability
  };

  services = {
    blueman.enable = true;
    upower.enable = true;
    fstrim.enable = true;
  };
}
