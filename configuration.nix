{ config, pkgs, ... }:

{
  #boot stuff
  boot = {
    #boot.kernelPackages = pkgs.linuxPackages_latest;

    #enable grub as boootloader
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        useOSProber = true;
        devices = [ "nodev" ];
        efiSupport = true;
        enable = true;
        configurationLimit = 2;
      };
    };

    #enable splash screen
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
      theme = "deus_ex";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "deus_ex" "lone" "rings" ];
        })
      ];
    };
  };

  #system versionn, do not change
  system.stateVersion = "25.05"; 

  #networking and time
  networking.networkmanager.enable = true;
  networking.hostName = "bloppai"; # Define your hostname.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8096 8920 ];
    allowedUDPPorts = [ 1900 7359 ];
  };
  #use iwd as backend
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    Network = {
      EnableIPv6 = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
  networking.networkmanager.wifi.backend = "iwd";
 
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
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "video" "input"];
    packages = with pkgs; [];
  };

  #nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  #hardware settings 
  security.rtkit.enable = true; #for improved audio performance
  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
  };
 
  #environment
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; #wayland apps use ozone
    grim="grimblast";
    wl="wl-copy";
    MOZ_ENABLE_WAYLAND = 0;
    cmpl="g++ -std=c++17 -Wall -Wextra -pedantic-errors -Weffc++ -Wno-unused-parameter -fsanitize=undefined,address *.cpp"; #for CSCE120 cpp compiler options
  };
  environment.systemPackages = with pkgs; [
    #must have
    vim curl wget

    #utilities
    pavucontrol fastfetch brightnessctl unzip swaynotificationcenter playerctl unrar ntfs3g btop hyprpaper nmap openssl dig rofi acpilight zip lazygit efibootmgr

    #programming sht
    python3 texliveFull uv gcc gnumake libgccjit gdb cmake nodejs sqlite texliveSmall R ghc ihaskell postgresql jdk17 railway lua
    
    #rendering libraries and graphics stuff
    gtk3 gtk4 glib xwayland

    #input stuff (copy, screenshot)
    grimblast slurp wl-clipboard

    #nice apps 
    kitty mullvad-vpn qbittorrent vlc tor-browser chromium nautilus

    #neovim plugins, LSP, etc
    tree-sitter luarocks ripgrep fd prettier stylua black shfmt python3Packages.pip lua-language-server pyright typescript-language-server yaml-language-server clang-tools ruff stylua zathura xdotool haskellPackages.fourmolu nil haskell-language-server texlab

    #yucky apps 
    zoom-us spotify vscode

    #python packages
    python312 python312Packages.numpy python312Packages.virtualenv python312Packages.requests
  ];

  #services
  services = {
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    blueman.enable = true;

    pulseaudio.enable = false; #using pipewire instead
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    supergfxd = {
      enable = true;
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };

    xserver.xkb.layout = "us"; #x11 fallback
  };

  #programs
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    chromium.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    git.enable = true;
    waybar.enable = true;
  };

  #virtualisation
  virtualisation.docker.enable = true;
  
  #fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];
  };
}
