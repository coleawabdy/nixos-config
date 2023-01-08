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
          alsa-utils
          gcc
          cmake
          steam-tui
          steamcmd
          gnucash
          megacmd
          libreoffice
          todoist-electron
          obsidian
          signal-desktop
          gcalcli
       ];

        sessionVariables = {
          EDITOR = "vim";
          TERM = "alacritty";
        };
      };
      
      news.display = "silent";

      programs.vscode = {
        enable = true;
        extensions = with pkgs; [
          vscode-extensions.vadimcn.vscode-lldb
          vscode-extensions.matklad.rust-analyzer
          vscode-extensions.arcticicestudio.nord-visual-studio-code
          vscode-extensions.tamasfe.even-better-toml
        ];
      };

   };
  in [
    inputs.hyprland.homeManagerModules.default
    (import ./modules/firefox.nix)
    (import ./modules/git.nix)
    (import ./modules/alacritty.nix)
    (import ./modules/desktop/desktop.nix)
    config
  ]
