{ nixpkgs, inputs, people }:

with nixpkgs.lib.lists;
with inputs.home-manager;
builtins.listToAttrs (
  lists.flatten (
    map (person:
      map (host:
        {
          name = "${person.name}@${host}";
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;

            modules = [];
          };
        }
      ) person.hosts
    ) people
  )
)
