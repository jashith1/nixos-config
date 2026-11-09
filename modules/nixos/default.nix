# Reusable system modules. Host-specific things live in hosts/<name>/.
{ inputs, ... }:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin

    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./nix.nix
    ./hardware.nix
    ./audio.nix
    ./input.nix
    ./fonts.nix
    ./desktop.nix
    ./sddm.nix
    ./programs.nix
    ./virtualisation.nix
    ./media-server.nix
    ./vpn.nix
    ./home-manager.nix
  ];
}
