{ ... }:

{
  services = {
    jellyfin = {
      enable = true;
      user = "bloppai";
    };

    seerr.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8096 8920 ];
    allowedUDPPorts = [ 1900 7359 ];
  };
}
