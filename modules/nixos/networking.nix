{ ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd"; #use iwd as backend
    };

    firewall.enable = true;

    wireless.iwd = {
      enable = true;
      settings = {
        Network.EnableIPv6 = true;
        Settings.AutoConnect = true;
      };
    };
  };
}
