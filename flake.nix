{
  description = "NixOS system using flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    terminaltexteffects = {
      url = "github:ChrisBuilds/terminaltexteffects";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.bloppai = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        nixos-hardware.nixosModules.asus-zephyrus-ga402
      ];
    };
  };
}

