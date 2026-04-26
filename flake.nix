{
  description = "Nixos config flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      inherit (self) outputs;
      defaultWallpaper = ./images/wallpaper.jpg;
    in
    {
      # NixOS configuration entrypoint
      nixosConfigurations = {
        # Config for gpteapot system
        udev = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs defaultWallpaper; };
          modules = [
            # System-level configuration
            ./system/configuration.nix

            # Stylix
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              # Home manager modules
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              # User-specific configs
              home-manager.users.tor = import ./home;
            }
          ];
        };
      };
    };
}
