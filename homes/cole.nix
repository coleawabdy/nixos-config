inputs:

  let
    config = { config, lib, pkgs, stdenv, ... }:

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
          vim
          htop
          tmux
          alacritty
          source-code-pro
          alsa-utils
          pciutils
        ];

        sessionVariables = {
          EDITOR = "vim";
          TERM = "alacritty";
        };
      };
      
      news.display = "silent";

      xdg.configFile = {
        "alacritty.yml".source = ../config/alacritty.yml;
      };

      programs.vscode = {
        enable = true;
      };
    };
  in [
    inputs.hyprland.homeManagerModules.default
    (import ./modules/firefox.nix)
    (import ./modules/git.nix)
    (import ./modules/desktop/desktop.nix)
    config
  ]
