hosts: { inputs }:

with builtins;
let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in listToAttrs (
  map (host: 
    let 
      hostInfo = import ../hosts/${host}.nix; 
    in {
      name = host;
      value = nixosSystem {
        system = hostInfo.system;
        modules = [
          ../hosts/modules/common.nix
          { networking.hostName = host; }
        ] ++ hostInfo.modules;
      };
    }
  ) hosts
)
