{
  system = "x86_64-linux";
  host = { config, pkgs, lib, ... }:
  {
    nixpkgs.config.allowUnfree = true;
    
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
    };
    
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware.opengl.enable = true;
    
    environment.systemPackages = with pkgs; [    
      pkgs.alacritty
      pkgs.firefox-wayland
    ];

    programs.xwayland.enable = true;
    programs.hyprland.enable = true;
  };
}
