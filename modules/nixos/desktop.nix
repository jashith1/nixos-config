# Wayland desktop session (login screen is in sddm.nix).
{ ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  services = {
    gvfs.enable = true; # Nautilus trash and virtual filesystem support

    xserver = { #x11 fallback
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
    };
  };
}
