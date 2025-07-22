{ config
, pkgs
, ...
}:

{
  stylix.targets.hyprpaper.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/nixos/images/miator_39.png" ];
      wallpaper = [ ",~/nixos/images/miator_39.png" ];

      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
}
