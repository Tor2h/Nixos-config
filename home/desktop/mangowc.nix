{ inputs, lib, config, pkgs, ... }: {
  imports = [ ];

  stylix.targets.mango.enable = true;

  # Extra "inventory space"
  # home.sessionVariables = { HYPRLAND_INVENTORY = 1; };

  programs.mangowc.enable = true;
}

