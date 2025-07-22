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

    stylix.url = "github:danth/stylix";

    # hyprland = {
    #   url = "github:hyprwm/hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, stylix, sddm-sugar-candy-nix, ... }@inputs:
    let
      inherit (self) outputs;
      defaultWallpaper = ./images/miator_17.jpg;
    in
    {
      # NixOS configuration entrypoint
      nixosConfigurations = {
        # Config for gpteapot system
        udev = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs defaultWallpaper; };
          modules = [
            # System-level configuration
            ./system/configuration.nix
            sddm-sugar-candy-nix.nixosModules.default

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
