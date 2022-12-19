{ nixpkgs, inputs, people }:

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
              inputs.home-manager.nixosModules.home-manager
              hostInfo.host
              {
                users.users = builtins.listToAttrs (
                    map (person:
                      {
                        name = person.name;
                        value = {
                          isNormalUser = true;
                          extraGroups = person.groups;
                        };
                      }
                    ) (builtins.filter (person: builtins.any (host: host == hostname) person.hosts) people)
                );

                networking.hostName = "${hostname}"; 
                
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.cole = import ../users/cole/home.nix;
                };
             }
            ];
          };
    }) ( nixpkgs.lib.lists.unique ( nixpkgs.lib.lists.flatten ( map (person: person.hosts ) people ) ) )
  )

