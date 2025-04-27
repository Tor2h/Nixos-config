{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./waybar.nix
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

  # Launcher
  stylix.targets.tofi.enable = true;
  programs.tofi = {
    enable = true;

    settings = {
      anchor = "bottom-left";
      corner-radius = "10";
      prompt-background-corner-radius = "10";
      margin-left = "40";
      margin-bottom = "90";
      outline-width = "0";
      width = "30%";
      height = "40%";
    };
  };
}
