# Wires home-manager into the system; the user config itself lives in /home.
{ inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.bloppai = import ../../home;
  };
}
