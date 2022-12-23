{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    swaybg
    rofi-wayland
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "rofi/config.rasi".source = ./rofi.rasi;
    "wallpaper.png".source = ./wallpaper.png;
  };
}
