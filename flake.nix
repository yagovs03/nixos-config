{
  description = "NixOS + Home Manager (minimal)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos/configuration.nix

        home-manager.nixosModules.home-manager
	{
          nixpkgs.overlays = [ nur.overlay ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users.agallas = import ./home/agallas.nix;
        }
      ];
    };
  };
}

