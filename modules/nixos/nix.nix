{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "bloppai" ];
      #access-tokens = [ "github.com=" ];
    };

    gc = {
      dates = "weekly";
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  #just symlink etc/nixos to nixos-config for consistency/norms
  environment.etc."nixos".source = "/home/bloppai/nixos-config";
}
