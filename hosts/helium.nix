let
  config = { config, lib, pkgs, ... }: {
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
    boot.blacklistedKernelModules = [ "psmouse" ];
    boot.initrd.luks.devices.nixos = {
      device = "/dev/disk/by-label/NIXOS";
      preLVM = true;
    };

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
      }
    ];

    networking.useDHCP = true;

    powerManagement.cpuFreqGovernor = "powersave";
    hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
    hardware.enableRedistributableFirmware = true;

    boot.kernel.sysctl = {
      "kernel.unprivileged_userns_clone" = 1;
    };

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    services.fwupd.enable = true;
    
    hardware.opengl.enable = true;
    hardware.pulseaudio.enable = false;
    hardware.firmware = with pkgs; [
      sof-firmware
    ];

    environment.systemPackages = with pkgs; [
      tzupdate
    ];
  };
in {
  system = "x86_64-linux";
  modules = [
    (import ./modules/bluetooth.nix)
    config
  ];
}
