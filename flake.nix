{
  description = "System configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

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
  in {
    nixosConfigurations = mkNixOSConfigs {
      inherit nixpkgs inputs; 
    };
    
    homeConfigurations.cole = 
    with inputs;
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config.allowUnfree = true;
      };
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        hyprland.homeManagerModules.default
        ./users/cole/home.nix
      ];
    };
 };
}
