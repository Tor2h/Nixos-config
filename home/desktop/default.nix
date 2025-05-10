{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./rofi.nix
  ];

  # Notification daemon
  stylix.targets.dunst.enable = true;
  services.dunst = {
    enable = true;
    settings.global = {
      offset = "30x30";
      corner_radius = "12";
      padding = "12";
      horizontal_padding = "12";
    };
  };
}
