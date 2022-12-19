{ config, lib, pkgs, stdenv, ... }:

let
  username = "cole";
  homeDirectory = "/home/cole";
  configHome = "${homeDirectory}/.config";

in {
  programs.home-manager.enable = true;

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";

    packages = with pkgs; [
      git
      vim
      htop
      tmux
      alacritty
    ];

    sessionVariables = {
      EDITOR = "vim";
      TERM = "alacritty";
    };
  };
  
  wayland.windowManager.hyprland.enable = true;

  news.display = "silent";

  xdg.configFile = {
    "alacritty.yml".source = ../../config/alacritty.yml;
    "hypr/hyprland.conf".source = ../../config/hyprland.conf;
  };
}
