{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # various config files
    ./kitty.nix
    # ./fish.nix
    # ./starship.nix
  ];
}
