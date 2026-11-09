# GTK, icons, cursor and catppuccin.
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  catppuccin = {
    enable = true;
    autoEnable = false;
    flavor = "mocha";
    accent = "mauve";
  };

  gtk = {
    enable = true;
    colorScheme = "dark";

    # Standard sidebar shortcuts for Nautilus and GTK file choosers.
    gtk3.bookmarks = [
      "file://${config.xdg.userDirs.download}"
      "file://${config.home.homeDirectory}/programming Programming"
      "file://${config.xdg.userDirs.documents}"
      "file://${config.xdg.userDirs.pictures}"
      "file://${config.xdg.userDirs.music}"
      "file://${config.xdg.userDirs.videos}"
    ];

    iconTheme = {
      name = "Colloid-Purple-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "purple" ];
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";

    size = 24;
    hyprcursor.size = 24;
  };
}
