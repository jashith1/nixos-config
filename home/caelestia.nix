# Desktop shell (caelestia) plus the other bits of the rice.
{ config, inputs, ... }:

{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  programs = {
    waybar.enable = true;
    hyprlock.enable = true;

    caelestia = {
      enable = true;
      settings = {
        general = {
          idle = {
            timeouts = []; #don't have any timouts
            lockBeforeSleep = false; #when laptop dies, attempts sleeping first dont lock when that happens
          };

          showOverFullscreen = true; #i think this is supposed to show toasts over fullscreen but isnt working
        };

        notifs = {
          fullscreen = "On";
        };

        utilities = {
          toasts = {
            fullscreen = "all";
          };
        };

        bar = {
          scrollActions = {
            brightness = false;
            volume = false;
          };
        };

        sidebar.enabled = false; #isnt working :(

        services = {
          useFahrenheitPerformance = false;
        };

        background = {
          enabled = true;
          wallpaperEnabled = true;
        };

        paths.wallpaperDir = "${config.home.homeDirectory}/.config/wallpapers";
      };

      cli = {
        enable = true; # Also add caelestia-cli to path

        #force custom gtk scheme instead of dynamic
        settings.theme.iconTheme = config.gtk.iconTheme.name;
      };
    };
  };
}
