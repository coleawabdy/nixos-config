{
  description = "System configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nurpkgs.url = github:nix-community/NUR;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  
  with inputs;
  let
    mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
    mkHomeConfigs = import ./lib/mkhomeconfigs.nix;
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        inputs.nurpkgs.overlay
        inputs.hyprland.overlays.default
      ];
    };
  in {
    nixosConfigurations = mkNixOSConfigs [
      "hydrogen"
      "helium"
    ] {
      inherit inputs pkgs; 
    };
    
    homeConfigurations = mkHomeConfigs [
      "cole"
    ] {
      inherit inputs pkgs;
    };
 };
}
