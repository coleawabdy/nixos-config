hosts: { inputs, pkgs }:

with builtins;
let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in listToAttrs (
  map (host: 
    let 
      hostInfo = (import ../hosts/${host}.nix) { inherit inputs; };
    in {
      name = host;
      value = nixosSystem {
        inherit pkgs;
        system = hostInfo.system;
        modules = [
          ../hosts/modules/common.nix
          { networking.hostName = host; }
        ] ++ hostInfo.modules;
      };
    }
  ) hosts
)
