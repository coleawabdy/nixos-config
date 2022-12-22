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
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  
  with inputs;
  let
   mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
  in {
    nixosConfigurations = mkNixOSConfigs [
      "hydrogen"
      "helium"
    ] {
      inherit inputs; 
    };
    
    homeConfigurations.cole = 
    with inputs;
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nurpkgs.overlay ];
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
