{
  description = "Nixos config flake";

  inputs = {
    ############### Official nixos/hm sources ###############
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    ############### External sources  ###############
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs =
    { nixpkgs, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
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
          modules = [
            ./hosts/xps
            nixos-hardware.nixosModules.dell-xps-13-7390
          ];
        };
        # Old work desktop
        donkeykong = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/donkeykong ];
        };
        # New work desktop
        jzargo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/jzargo ];
        };
        # Oceanbox desktop
        haddock = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ ./hosts/haddock ];
        };
        # New Oceanbox desktop
        dipper = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [ 
            ./hosts/dipper 
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-amd
          ];
        };
        # Oceanbox laptop
        diver = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            ./hosts/diver
            # TODO: Use gen6 when available
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5
          ];
        };
      };
    };
}
