homes: { inputs }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [ inputs.nurpkgs.overlay ];
  };
  homeManagerConfiguration = inputs.home-manager.lib.homeManagerConfiguration;
in builtins.listToAttrs (
  map (home: 
    let 
      homeModules = import ../homes/${home}.nix;
    in {
      name = home;
      value = homeManagerConfiguration {
        inherit pkgs;
        modules = (homeModules inputs);
      };
  }) homes
)
