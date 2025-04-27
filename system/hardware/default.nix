{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./nvidia.nix ./backlight.nix ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
