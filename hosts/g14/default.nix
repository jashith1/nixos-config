# ASUS ROG Zephyrus G14 (Ryzen 9 6900HS).
{ ... }:

{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./core0-stability.nix
  ];

  networking.hostName = "g14";

  #system version, do not change
  system.stateVersion = "25.05";

  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelParams = [
    #gpu fix testing
    "amd_pstate=active"
    #"amdgpu.sg_display=0"     # Disables Scatter/Gather (fixes flickering on some APUs)
    "iommu=pt"

    #removed idle tweaks: crashes are a marginal core 0, see core0-stability.nix
    #idle=poll (tested sep 28 - oct 4) and idle=nomwait/processor.max_cstate=1 didn't stop them and cost battery
  ];

  #ASUS laptop services
  services = {
    asusd.enable = true;
    cardwired.enable = true;
  };

  #suspend sometimes doesn't reach deep sleep and the clock keeps running for minutes,
  #so systemd's 3min watchdog kills logind/journald on resume -> session lost, sddm loop, wifi never woken
  systemd.services.systemd-logind.serviceConfig.WatchdogSec = 0;
  systemd.services.systemd-journald.serviceConfig.WatchdogSec = 0;
}
