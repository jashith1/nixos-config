{ config, pkgs, ... }:

{
  #boot stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #system versionn, do not change
  system.stateVersion = "25.05"; 

  #networking and time
  networking.networkmanager.enable = true;
  networking.hostName = "bloppai"; # Define your hostname.
  
  time.timeZone = "America/Chicago";

  #language and locale settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_ALL = "en_US.UTF-8";
  };

  #users
  # Don't forget to set a password with ‘passwd’.
  users.users.bloppai = {
    isNormalUser = true;
    description = "bloppai";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [];
  };

  #nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  #environment
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; #wayland apps use ozone
  };
  environment.systemPackages = with pkgs; [
    #must have for any system
    vim kitty git firefox neovim

    #nice to have utilities
    kanshi pavucontrol mullvad-vpn fastfetch brightnessctl fastfetch waybar unzip

    #programming sht
    python314 texliveFull uv gcc gnumake libgccjit gdb
    
    #rendering libraries and graphics stuff
    gtk3 gtk4 glib mesa xwayland

    #input stuff (copy, screenshot)
    grimblast slurp wl-clipboard
  ];

  #services
  services = {
    mullvad-vpn.enable = true;
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };

    xserver.xkb.layout = "us"; #x11 fallback
  };

  #programs
  programs.hyprland.enable = true;
}
