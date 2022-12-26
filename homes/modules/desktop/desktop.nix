{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts-emoji
    swaybg
    rofi-wayland
    megasync
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.enable = true;
  
  programs = {
    waybar.enable = true;
  };

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "rofi/config.rasi".source = ./rofi.rasi;
    "waybar/config".source = ./waybar.json;
    "waybar/style.css".source = ./waybar.css;
    "wallpaper.png".source = ./wallpaper.png;
  };
}
