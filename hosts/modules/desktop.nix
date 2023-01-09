{ hyprland, pkgs, ... }:

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  environment.systemPackages = with pkgs; [
    lxsession
    swaylock
    swaybg
    pcmanfm
    shared-mime-info
    nordic
    zafiro-icons
    numix-cursor-theme
    xdg-utils
    libnotify
    rofi-wayland
    networkmanagerapplet
    libappindicator
    libimobiledevice
    waybar
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [
      "JetBrainsMono"
      "Noto"
    ]; })
    liberation_ttf
    noto-fonts
    noto-fonts-emoji
  ];

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  services = {
    usbmuxd.enable = true;
  };

  xdg.portal.wlr.enable = true;

  security.pam.services.swaylock = {
    text = "auth include login";
  };
}