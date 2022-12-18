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
              {
                users.users = builtins.listToAttrs ( 
                  map (person:
                    {
                      name = "${person.name}";
                      value = {
                        isNormalUser = true;
                        extraGroups = person.groups;
                      };
                    }
                  ) 
                  ( builtins.filter (person: 
                      builtins.any (host: host == "${hostname}") 
                    ) (import ../people.nix).hosts
                  )
                );

                networking.hostName = "${hostname}"; 
              }
            ];
          };
    }) 
    hostnames )
