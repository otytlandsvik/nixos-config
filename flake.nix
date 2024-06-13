{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations = {
        # Home desktop
        beiste = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/beiste ];
        };
        # Uni desktop
        bubbles = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/bubbles ];
        };
        # Dell laptop
        xps = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/xps ];
        };
      };
    };
}
