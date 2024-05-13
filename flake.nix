{
  description = "Nixos config flake";

  inputs = {
    ############### Official nixos/hm sources ###############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ############### External sources  ###############

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = {
        inherit inputs outputs nixpkgs;
      };
    in
    {

      nixosConfigurations = {
        beiste = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/beiste
          ];
        };
        bubbles = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/bubbles
          ];
        };
      };
    };
}
