let
  config = { config, lib, pkgs, ... }: {
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [
			"dm-snapshot"
      "amdgpu"
		];
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
      { device = "/dev/main/swap"; }
    ];
    
    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };


    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

		environment.sessionVariables = {
		};

		environment.systemPackages = with pkgs; [
		];

		services.xserver.videoDrivers = [ "amdgpu" ];

		hardware.opengl.extraPackages = with pkgs; [
		];
    hardware.opengl.enable = true;
    hardware.pulseaudio.enable = false;

    services.dbus.enable = true;
  };
in { inputs }: {
  system = "x86_64-linux";
  modules = [
    inputs.hyprland.nixosModules.default
    (import ./modules/desktop.nix)
		(import ./modules/security.nix)
    config
  ];
}
