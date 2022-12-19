{ pkgs, ... }: {
  home.packages = [
    pkgs.vim
    pkgs.htop
  ];

  home.stateVersion = "22.11";
}
