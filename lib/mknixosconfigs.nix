hostnames: { nixpkgs, inputs }:

builtins.listToAttrs
  ( map (hostname:
    { 
      name = "${hostname}"; 
      value = 
        let 
          hostInfo = import ../hosts/${hostname}.nix;
          people = import ../people.nix;
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
                        name = person.name;
                        value = {
                          isNormalUser = true;
                          extraGroups = person.groups;
                        };
                      }
                    ) (builtins.filter (person: builtins.any (host: host == hostname) person.hosts) people)
                );

                networking.hostName = "${hostname}"; 
              }
            ];
          };
    }) 
    hostnames )

