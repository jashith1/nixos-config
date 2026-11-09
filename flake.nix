{
  description = "NixOS system using flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; #stable

    home-manager = {
      url = "github:nix-community/home-manager/";
      #url = "github:nix-community/home-manager/release-25.11"; #stable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #my laptop's default settings, disabling because it's power policy is too aggressive
    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    terminaltexteffects = {
      url = "github:ChrisBuilds/terminaltexteffects";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      mkHost = { system ? "x86_64-linux", modules }:
        nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations.g14 = mkHost {
        modules = [ ./hosts/g14 ];
      };
    };
}
