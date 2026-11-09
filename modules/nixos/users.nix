{ pkgs, ... }:

{
  # Don't forget to set a password with ‘passwd’.
  users.users.bloppai = {
    isNormalUser = true;
    description = "bloppai";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "video" "input" "uinput" ];
    shell = pkgs.zsh;
  };
}
