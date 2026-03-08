{ config, pkgs, inputs, ... }:

{
  imports = [inputs.silentSDDM.nixosModules.default];

  #boot stuff
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages;

    initrd.includeDefaultModules = true; #loads some kernel modules to initrd, adds stability to early boot process visuals

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
        configurationLimit = 3;
      };
    };

    #enable splash screen
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
        #quiet the boot screen
        #"quiet"
        #"udev.log_priority=3"
        #"systemd.show_status=auto"

        #gpu fix testing
        "amdgpu.dcdebugmask=0x10" # Disables PSR (Panel Self Refresh)
        "amdgpu.sg_display=0"     # Disables Scatter/Gather (fixes flickering on some APUs)
        "idle=nomwait"
        "nomodeset"
    ];

    #plymouth = {
      #enable = true;
      #theme = "deus_ex";
      #themePackages = with pkgs; [
      #  (adi1090x-plymouth-themes.override {
      #    selected_themes = [ "deus_ex" "lone" "rings" ];
      #  })
      #];
    #};
  };

  #system versionn, do not change
  system.stateVersion = "25.05"; 

  #just symlink etc/nixos to nixos-config for consistency/norms
  environment.etc."nixos".source = "/home/bloppai/nixos-config";

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
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "video" "input" "uinput"];
    shell = pkgs.zsh;
  };

  #nix settings
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "bloppai" ];
      #access-tokens = [ "github.com=" ]; 
    };

    gc = {
      dates = "weekly";
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  #hardware settings 
  security.rtkit.enable = true; #for improved audio performance
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    amdgpu.initrd.enable = true; #loads amd drivers to initrd, helps early boot visual stability
  };
 
  #environment
  environment.systemPackages = with pkgs; [
    #programming sht
    #python3 texliveFull uv gcc gnumake libgccjit gdb cmake nodejs sqlite texliveSmall R ghc ihaskell postgresql jdk17 railway lua
    
    #neovim plugins, LSP, etc
    #tree-sitter luarocks ripgrep fd prettier stylua black shfmt python3Packages.pip lua-language-server pyright typescript-language-server yaml-language-server clang-tools ruff stylua zathura xdotool haskellPackages.fourmolu nil haskell-language-server texlab
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
    upower.enable = true;

    supergfxd.enable = true;
    asusd.enable = true;

    fstrim.enable = true;

    keyd = {
      enable = true;
      keyboards.default.settings.main = {
        #for vim
        capslock = "esc";
      };
    };

    xserver = { #x11 fallback
      xkb.layout = "us";
      videoDrivers = ["amdgpu"];
    };
  };

  #programs
  programs = {
    hyprland.enable = true;
    zsh.enable = true;
    bash.enable = true;
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

