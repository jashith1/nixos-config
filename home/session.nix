# Environment variables and dotfile links.
{ config, ... }:

{
  home = {
    shell.enableZshIntegration = true;

    sessionVariables = {
      NIXOS_OZONE_WL = "1"; #wayland apps use ozone
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      MOZ_ENABLE_WAYLAND = 1;
      MANPAGER = "bat -plman";
      XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots/";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };

    file = {
      ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/zsh/.zshrc"; #symlink .zshrc file to the actual one inside .config
      "Media/windows_media".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/windows/media"; #symlink jellyfin media source to point to windows partition
      ".face".source = ../wallpapers/Araragi.jpeg; #.face is read by a lot of apps for user photo
    };
  };
}
