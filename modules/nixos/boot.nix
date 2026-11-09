{ pkgs, ... }:

{
  boot = {
    #kernelPackages = pkgs.linuxPackages;
    kernelPackages = pkgs.linuxPackages_latest;

    #zen kernel
    #kernelPackages = pkgs.linuxPackages_zen;

    initrd.includeDefaultModules = true; #loads some kernel modules to initrd, adds stability to early boot process visuals

    #enable grub as boootloader
    loader = {
      timeout = 2;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        useOSProber = true;
        devices = [ "nodev" ];
        efiSupport = true;
        enable = true;
        configurationLimit = 3;
        memtest86.enable = true;
      };
    };

    #enable splash screen
    consoleLogLevel = 3;
    kernelParams = [
      #quiet the boot screen
      #"quiet"
      #"udev.log_priority=3"
      #"systemd.show_status=auto"
    ];

    #plymouth = {
    # enable = true;
    # theme = "deus_ex";
    # themePackages = with pkgs; [
    #   (adi1090x-plymouth-themes.override {
    #     selected_themes = [ "deus_ex" "lone" "rings" ];
    #   })
    # ];
    #};

    supportedFilesystems = [ "ntfs" ]; #for windows support
  };
}
