{ config, pkgs, lib, defaultWallpaper, ... }: {
  # Set the sddm theme
  services.xserver.displayManager.sessionPackages = [
    inputs.mangowc.packages.${pkgs.system}.default
  ];
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
