{ config, pkgs, ... }: {
  imports = [ ];

  nix.settings.trusted-users = [ "root" "tor" ];
}
