{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaybg
    rofi-wayland
  ];

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "rofi/config.rasi".source = ./rofi.rasi;
    "rofi/vars.rasi".source = ./vars.rasi;
    "wallpaper.png".source = ./wallpaper.png;
  };
}
