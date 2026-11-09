{ ... }:

{
  programs = {
    zsh.enable = true;
    bash.enable = true;
    #dynamic library management
    nix-ld.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
