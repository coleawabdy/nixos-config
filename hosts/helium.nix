{
  system = "x86_64-linux";
  host = { config, lib, ... }:
  {
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.initrd.luks.devices.nixos = "/dev/disk/by-label/NIXOS";

    fileSystems = {
      "/" = {
        device = "/dev/main/root";
        fsType = "btrfs";
      };

      "/boot" = {
        device = "/dev/disk/by-label/BOOT";
        fsType = "vfat";
      };
    };

    swapDevices = [
      {
        device = "/dev/main/swap";
        preLVM = true;
      }
    ];

    networking.useDHCP = true;

    powerManagement.cpuFreqGovernor = "powersave";
    hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}
