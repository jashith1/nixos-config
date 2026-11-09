{ config, ... }:

{
  xdg = {
    enable = true; #enable xdg directory management
    mimeApps = {
      enable = true;
      defaultApplications."application/zip" = [ "org.gnome.Nautilus.desktop" ];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };
}
