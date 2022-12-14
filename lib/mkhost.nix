hostname: { nixpkgs, system }:

nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    ../configuration.nix
    ../hosts/${hostname}.nix
    { networking.hostName = "${hostname}"; }
  ];
}
