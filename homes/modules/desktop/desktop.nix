{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ 
      "JetBrainsMono"
      "Noto"
    ]; })
    noto-fonts-emoji
    liberation_ttf
    swaybg
    rofi-wayland
    networkmanagerapplet
    libnotify
    lxsession
    zafiro-icons
    pcmanfm
    shared-mime-info
    nordic
    numix-cursor-theme
    xdg-utils
    libappindicator
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.enable = true;
  
  programs = {
    waybar.enable = true;
  };

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

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Unity";
  };
}
