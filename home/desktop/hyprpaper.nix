{ config
, pkgs
, ...
}:

{
  stylix.targets.hyprpaper.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/nixos/images/wallpaper_default.png" ];
      wallpaper = [ ",~/nixos/images/wallpaper_default.png" ];

      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
}
