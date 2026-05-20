{ inputs, pkgs, ... }:
{
  programs.waybar.enable = false;

  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  xdg.configFile."quickshell".source = ./quickshell;
}
