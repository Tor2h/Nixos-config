{ inputs, pkgs, ... }:
{
  programs.waybar.enable = false; # disable waybar

  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  # Write the QML config
  xdg.configFile."quickshell/shell.qml".source = ./quickshell/shell.qml;
  xdg.configFile."quickshell/components/Dashboard.qml".source = ./quickshell/components/Dashboard.qml;
  xdg.configFile."quickshell/components/MusicPanel.qml".source = ./quickshell/components/MusicPanel.qml;
  xdg.configFile."quickshell/components/WifiPanel.qml".source = ./quickshell/components/WifiPanel.qml;
  xdg.configFile."quickshell/components/BluetoothPanel.qml".source = ./quickshell/components/BluetoothPanel.qml;
  xdg.configFile."quickshell/components/LauncherPanel.qml".source = ./quickshell/components/LauncherPanel.qml;
  xdg.configFile."quickshell/components/CalendarPanel.qml".source = ./quickshell/components/CalendarPanel.qml;
  xdg.configFile."quickshell/components/NotificationPopup.qml".source = ./quickshell/components/NotificationPopup.qml;
  xdg.configFile."quickshell/components/NotifCenter.qml".source = ./quickshell/components/NotifCenter.qml;
  xdg.configFile."quickshell/components/ClockPanel.qml".source = ./quickshell/components/ClockPanel.qml;
  xdg.configFile."quickshell/components/AnimePanel.qml".source = ./quickshell/components/AnimePanel.qml;
  xdg.configFile."quickshell/components/MoviesPanel.qml".source = ./quickshell/components/MoviesPanel.qml;
  xdg.configFile."quickshell/components/Bar.qml".source = ./quickshell/components/Bar.qml;
  xdg.configFile."quickshell/components/ClipboardPanel.qml".source = ./quickshell/components/ClipboardPanel.qml;
}
