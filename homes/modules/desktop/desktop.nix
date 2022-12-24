{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts-emoji
    swaybg
    rofi-wayland
    gcc
    lldb
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "rofi/config.rasi".source = ./rofi.rasi;
    "wallpaper.png".source = ./wallpaper.png;
  };
}
