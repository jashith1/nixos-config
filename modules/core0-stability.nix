{ ... }:

# Workaround for a marginal CPU core 0 (cpu0 + cpu1 SMT siblings) on the 6900HS.
# Pstore crash dumps (/var/lib/systemd/pstore) show nearly all oopses on cpu0/cpu1,
# mostly 6-8s into boot while amdgpu powers up the GPUs.
# Idea: keep core 0 at nominal clock (= higher voltage) during boot, then return
# to normal after 10 minutes so battery life isn't affected for the rest of the session.
let
  floorKHz = "3300000"; # nominal clock of the 6900HS
  cores = "0 1";
in
{
  #stage 1: set floor before amdgpu is loaded by systemd-modules-load
  boot.initrd.systemd.services.core0-minfreq = {
    wantedBy = [ "initrd.target" ];
    before = [ "systemd-modules-load.service" "systemd-udevd.service" ];
    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";
    script = ''
      for c in ${cores}; do
        echo ${floorKHz} > /sys/devices/system/cpu/cpu$c/cpufreq/scaling_min_freq || true
      done
    '';
  };

  #stage 2: restore default floor 10 minutes after boot
  systemd.services.core0-minfreq-reset = {
    serviceConfig.Type = "oneshot";
    script = ''
      for c in ${cores}; do
        d=/sys/devices/system/cpu/cpu$c/cpufreq
        cat $d/amd_pstate_lowest_nonlinear_freq > $d/scaling_min_freq
      done
    '';
  };
  systemd.timers.core0-minfreq-reset = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnBootSec = "10min";
  };
}
