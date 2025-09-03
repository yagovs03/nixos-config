{
  description = "NixOS + Home Manager (minimal)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, neovim-flake, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; overlays = [ nur.overlay ]; };
  in {
    # NixOS system (host) named "nixos"
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix

        # Integrate Home Manager into the OS rebuild
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
          home-manager.users.agallas = import ./home/agallas.nix;
          # (opcional pero recomendable) también fija el overlay a nivel del sistema
          nixpkgs.overlays = [ nur.overlay ];
        }
      ];
    };

    # (Optional) pure Home Manager target if you ever want HM-only switches
    homeConfigurations."agallas@nixos" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./home/agallas.nix ];
      };
  };
}
