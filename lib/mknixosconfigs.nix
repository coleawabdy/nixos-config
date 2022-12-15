hostnames: { nixpkgs, inputs }:

builtins.listToAttrs
  ( map (hostname:
    { 
      name = "${hostname}"; 
      value = 
        let 
          hostInfo = import ../hosts/${hostname}.nix;
        in
          nixpkgs.lib.nixosSystem {
            system = hostInfo.system;
            modules = [
              ../configuration.nix
              hostInfo.host
              { networking.hostName = "${hostname}"; }
            ];
          };
    }) 
    hostnames )
