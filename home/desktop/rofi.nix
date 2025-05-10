{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      icon-theme = "Noto Color Emoji";
      location = 0;
      font = "DejaVu Sans 16";
      drun-display-format = "{icon} {name}";
      display-drun = " Apps: ";
      display-run = " Run: ";
      display-filebrowser = " File: ";
    };
  };
}
