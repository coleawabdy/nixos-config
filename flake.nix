{
  description = "System configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  
  let
   mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
   mkHomeConfigs = import ./lib/mkhomeconfigs.nix;
  in {
    nixosConfigurations = mkNixOSConfigs {
      inherit nixpkgs inputs; 
    };

    homeConfigurations = mkHomeConfigs {
      inherit nixpkgs inputs;
    };
  };
}
