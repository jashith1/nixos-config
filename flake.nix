{
  description = "NixOS system using flakes";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; #stable

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #my laptop's default settings, disabling because it's power policy is too aggressive

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
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, silentSDDM, caelestia-shell, ... }@inputs: {
    nixosConfigurations.bloppai = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.bloppai = { ... }: {
            imports = [
              ./home/home.nix
              inputs.caelestia-shell.homeManagerModules.default
            ];
          };
        }

        #nixos-hardware.nixosModules.asus-zephyrus-ga402

        ./modules/silent-sddm.nix
      ];
    };
  };
}

