{  
  system = "x86_64-linux";
  host = { config, pkgs, lib, ... }:
  {
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usb_hid" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.extraKernelModules = [ ];

    fileSystems."/" = 
      {
        device = "/dev/main/root";
        fsType = "btrfs";
      };

    fileSystems."/boot" = 
      {
        device = "/dev/disk/by-label/BOOT";
        fsType = "vfat";
      };

    swapDevices = [];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
