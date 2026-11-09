{ ... }:

{
  services = {
    mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };

    tailscale.enable = true;
  };
}
