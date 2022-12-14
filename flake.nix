{
  description = "System configuration";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    polymc.url = "github:PolyMC/PolyMC"; 
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... } @ inputs: let
   mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
  in {
    nixosConfigurations = mkNixOSConfigs [ "hydrogen" ] {
      inherit nixpkgs inputs;
    };
  };
}
