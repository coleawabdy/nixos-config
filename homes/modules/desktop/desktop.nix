{ pkgs, ... }:


{
  fonts.fontconfig.enable = true;
  
  services = {
    dunst = {
      enable = true;
      configFile = ./dunstrc;
    };
  };

  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "rofi/config.rasi".source = ./rofi.rasi;
    "waybar/config".source = ./waybar.json;
    "waybar/style.css".source = ./waybar.css;
    "wallpaper.png".source = ./wallpaper.png;
  };
  
  gtk = {
    enable = true;
    cursorTheme.name = "numix";
    iconTheme.name = "Zafiro-icons-Dark";
    font.name = "JetBrainsMono Nerd Font";
    theme.name = "Nordic";
  };
}
