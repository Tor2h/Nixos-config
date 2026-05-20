{ inputs, lib, config, pkgs, ... }: {
  imports = [];

  stylix.targets.hyprland.enable = true;

  home.sessionVariables = { HYPRLAND_INVENTORY = 1; };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Disable HM's own config file generation
      settings = lib.mkForce {};
    extraConfig = lib.mkForce "# config managed via hyprland.lua";
  };

  # Write the Lua config ourselves
  xdg.configFile."hypr/hyprland.lua" = {
    source = ./hyprland.lua;
  };
}
