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
      wofi
      firefox
      alacritty
      source-code-pro
      vscode
      alsa-utils
      pciutils
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

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      localcdn
    ];
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;  
      };
    };
  };


}
