homes: { inputs, pkgs }:
let
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
