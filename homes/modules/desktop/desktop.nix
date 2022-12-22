{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaybg
  ];

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "wallpaper.png".source = ./wallpaper.png;
  };
}
