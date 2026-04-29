{ config, pkgs, inputs, ... }:

{
  home.username = "bloppai";
  home.homeDirectory = "/home/bloppai";

  # Import files from the current configuration directory into the Nix store,
  # and create symbolic links pointing to those store files in the Home directory.

  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Import the scripts directory into the Nix store,
  # and recursively generate symbolic links in the Home directory pointing to the files in the store.
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  home.shell.enableZshIntegration = true;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; #wayland apps use ozone
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = 0;
    MANPAGER="bat -plman";
  };

  xdg = {
    enable = true; #enable xdg directory management
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/x-bittorrent" = [ "qbittorrent.desktop" ];
        "x-scheme-handler/magnet" = [ "qbittorrent.desktop" ];
      };
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  #symlink .zshrc file to the actual one inside .config
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bloppai/.config/zsh/.zshrc";
  home.file.".face".source = ../wallpapers/Araragi.jpeg;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # file managers
    nautilus nnn

    # archives
    zip xz unzip unrar

    # cli utilities
    ripgrep jq yq-go fzf tmux curl wget openssl fd tree-sitter

    # system tools
    btop lm_sensors fastfetch brightnessctl efibootmgr ntfs3g railway

    # networking
    iperf3 dnsutils nmap

    # desktop / wayland tools
    rofi hyprpaper swaynotificationcenter grimblast slurp wl-clipboard xwayland playerctl quickshell

    # libraries
    glib

    # dev
    lazygit devenv texliveFull 

    # applications
    kitty spotify zoom-us vlc qbittorrent mullvad-vpn tor-browser pavucontrol jellyfin-desktop obsidian motrix

    #theming stuff
    bibata-cursors
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";

    size = 24;
    hyprcursor.size = 24;
  };

  programs = {
    #browsers
    firefox.enable = true;

    chromium.enable = true;

    #editors
    vim.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    #looks
    waybar.enable = true;

    hyprlock.enable = true;

    caelestia = {
      enable = true;
      settings = {
        general = {
          idle = {
            timeouts = [];
          };
        };
        bar = {
          status = {
            showAudio = true;
          };
        };

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
      };
    };

    #misc
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
        style = "plain";
      };
    };

    #dev tools
    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = "Jashith Raghavendra";
          email = "jashith.r1@gmail.com";
        };
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide.enable = true;

    bash.enable = true;

    #starship.enable = true;

    #While I do use devenv+direnv sometimes, it gets very messy when there are multiple venvs active
    #uv.enable = true;
  };

  home.stateVersion = "25.11"; #dont change
}
