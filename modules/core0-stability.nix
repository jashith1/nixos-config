{ ... }:

# Workaround for a marginal CPU core 0 (cpu0 + cpu1 SMT siblings) on the 6900HS.
# Pstore crash dumps (/var/lib/systemd/pstore) show nearly all oopses on cpu0/cpu1,
# mostly 6-8s into boot while amdgpu powers up the GPUs.
# Idea: keep core 0 at nominal clock (= higher voltage) during boot, then return
# to normal after 10 minutes so battery life isn't affected for the rest of the session.
#
# Core 0 is also kept out of the deep C2/C3 idle states (C1 only), permanently.
# Dropping processor.max_cstate=1 globally let core 0 into C2/C3 and in-session crashes
# went up (2 crashes in a few hours on kernel 7.3, both waking from idle on cpu0).
# Doing it per-cpu keeps the deep states (battery) on the other 7 cores.
let
  floorKHz = "3300000"; # nominal clock of the 6900HS
  cores = "0 1";
  limitCstates = ''
    for c in ${cores}; do
      for s in /sys/devices/system/cpu/cpu$c/cpuidle/state*; do
        case "$(cat $s/name)" in
          C2|C3) echo 1 > $s/disable || true ;;
        esac
      done
    done
  '';
in
{
  #stage 1: set floor + C-state limit before amdgpu is loaded by systemd-modules-load
  boot.initrd.systemd.services.core0-minfreq = {
    wantedBy = [ "initrd.target" ];
    before = [ "systemd-modules-load.service" "systemd-udevd.service" ];
    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";
    script = ''
      for c in ${cores}; do
        echo ${floorKHz} > /sys/devices/system/cpu/cpu$c/cpufreq/scaling_min_freq || true
      done
    '' + limitCstates;
  };

  #stage 2: re-apply C-state limit in case cpuidle wasn't ready in stage 1
  systemd.services.core0-cstate-limit = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = limitCstates;
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
