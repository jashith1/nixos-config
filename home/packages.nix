# Plain packages. Anything with real configuration belongs in its own module.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # file managers
    nautilus nnn

    # archives
    zip xz unzip unrar gnutar gnumake

    # cli utilities
    ripgrep jq yq-go fzf tmux curl wget openssl fd tree-sitter gcc gnumake gdb speedtest-cli ani-cli trash-cli yazi tldr

    # lsp
    # NOTE: There's duplicate installations from mason as fallback if using non nix distro
    clang-tools rust-analyzer
    #formatters
    rustfmt ruff
    #package managers
    cargo yarn gradle

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
    texliveFull nodejs python3 postgresql rustc go

    # applications
    kitty spotify zoom-us vlc qbittorrent tor-browser pavucontrol jellyfin-desktop obsidian swayimg
  ];
}
