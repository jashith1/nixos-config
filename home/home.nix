{ config, pkgs, inputs, ... }:

{
  home = {
    username = "bloppai";
    homeDirectory = "/home/bloppai";

    shell.enableZshIntegration = true;

    sessionVariables = {
      NIXOS_OZONE_WL = "1"; #wayland apps use ozone
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      MOZ_ENABLE_WAYLAND = 1;
      MANPAGER = "bat -plman";
      XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots/";
    };

    file = {
      ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bloppai/.config/zsh/.zshrc"; #symlink .zshrc file to the actual one inside .config
      "Media/windows_media".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/windows/media"; #symlink jellyfin media source to point to windows partition
      ".face".source = ../wallpapers/Araragi.jpeg; #.face is read by a lot of apps for user photo
    };
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

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # file managers
    nautilus nnn

    # archives
    zip xz unzip unrar gnutar gnumake

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

    # dev tools
    lazygit devenv

    #languages
    texliveFull nodejs python3

    # applications
    kitty spotify zoom-us vlc qbittorrent tor-browser pavucontrol jellyfin-desktop obsidian

    #theming stuff
    bibata-cursors
  ];

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
            timeouts = []; #don't have any timouts
            lockBeforeSleep = false; #when laptop dies, attempts sleeping first dont lock when that happens
          };
          showOverFullscreen = true; #i think this is supposed to show toasts over fullscreen but isnt working
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
