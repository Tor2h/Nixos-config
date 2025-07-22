{ pkgs, lib, config, ... }:
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
    theme = {
      window = {
        width = 500;
        border = 1;
      };
      listview = {
        enabled = true;
        columns = 1;
        dynamic = true;
        scrollbar = false;
        layout = "vertical";
        fixed-height = true;
        fixed-columns = true;
        border = 1;
      };
      inputbar = {
        padding = 10;
        border = 1;
      };
      element = {
        padding = 10;
        spacing = 10;
      };
      "element-icon" = {
        size = 24;
      };
    };
  };
}
