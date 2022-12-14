{
  description = "System configuration";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
 };

  outputs = { self, nixpkgs, ... } @ inputs: let
   mkNixOSConfigs = import ./lib/mknixosconfigs.nix;
  in {
    nixosConfigurations = mkNixOSConfigs [ "hydrogen" ] {
      inherit nixpkgs inputs;
    };
  };
}
