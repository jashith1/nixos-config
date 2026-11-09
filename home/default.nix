# User environment for bloppai. Each topic lives in its own file below.
{ ... }:

{
  imports = [
    ./session.nix
    ./xdg.nix
    ./theme.nix
    ./packages.nix
    ./shell.nix
    ./dev.nix
    ./editors.nix
    ./browsers.nix
    ./caelestia.nix
  ];

  home = {
    username = "bloppai";
    homeDirectory = "/home/bloppai";
    stateVersion = "25.11"; #dont change
  };
}
