{ config, pkgs, lib, defaultWallpaper, ... }: {
  # Set the sddm theme

  environment.etc."wayland-sessions/mango.desktop".text = ''
    [Desktop Entry]
    Name=Mango
    Comment=Start Mangowc Wayland Compositor
    Exec=mango
    Type=Application
    DesktopNames=Mango
  '';

  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.desktopManager.plasma5.enable = false;

  services.displayManager.sddm = {
    enable = true; # Enable SDDM.
    wayland.enable = true;
    enableHidpi = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        # General settings
        Background = lib.cleanSource defaultWallpaper;
        ScreenWidth = 2560;
        ScreenHeight = 1440;
        Font = "Iosevka nerd font";
        # Form settings
        HeaderText = "Welcome!";
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
        # Customize colors
        BackgroundColor = "#0c0b11";
        MainColor = "#908caa";
        AccentColor = "#9ccfd8";
      };
    };
  };
}
