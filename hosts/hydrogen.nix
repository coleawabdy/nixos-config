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
			"nvidia"
			"nvidia_modeset"
			"nvidia_uvm"
			"nvidia_drm"
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
			LIBVA_DRIVER_NAME = "nvidia";
			XDG_SESSION_TYPE = "wayland";
			GBM_BACKEND = "nvidia-drm";
			__GLX_VENDOR_LIBRARY_NAME = "nvidia";
			WLR_NO_HARDWARE_CURSORS = "1";
			EGL_PLATFORM = "wayland";
			MOZ_DISABLE_RDD_SANDBOX = "1";
		};

		environment.systemPackages = with pkgs; [
		];

		services.xserver.videoDrivers = [ "nvidia" ];

		programs.hyprland.nvidiaPatches = true;
		
		hardware.opengl.extraPackages = with pkgs; [
			nvidia-vaapi-driver
		];
    hardware.opengl.enable = true;
		hardware.nvidia.modesetting.enable = true;
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
