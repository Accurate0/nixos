{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nix-ld, self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos =
      let
        nixpkgs-config = {
          allowUnfree = true;
        };
        # configure pkgs to include unstable as pkgs.unstable
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = final.system;
                config = nixpkgs-config;
              };
            })
          ];
          config = nixpkgs-config;
        };
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          nix-ld.nixosModules.nix-ld
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.anurag = {
              imports = [ ./home.nix ];
            };
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
          }
          {
            nixpkgs = { inherit pkgs; };
          }
        ];
      };
  };
}
