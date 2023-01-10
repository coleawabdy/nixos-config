{
  description = "System configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

    nurpkgs.url = github:nix-community/NUR;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  
  with inputs;
  let
   mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
   mkHomeConfigs = import ./lib/mkhomeconfigs.nix;
  in {
    nixosConfigurations = mkNixOSConfigs [
      "hydrogen"
      "helium"
    ] {
      inherit inputs; 
    };
    
    homeConfigurations = mkHomeConfigs [
      "cole"
    ] {
      inherit inputs;
    };
 };
}
