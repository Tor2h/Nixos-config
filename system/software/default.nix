{ config, pkgs, ... }: {
  imports = [
    ./display
    ./audio.nix
    ./programs.nix
    ./stylix.nix
    ./settings.nix
    ./fonts.nix
  ];
}
