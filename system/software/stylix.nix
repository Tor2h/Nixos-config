{ config, pkgs, defaultWallpaper, ... }:

{
  stylix = {
    # Colours
    enable = true;
    image = defaultWallpaper;
    polarity = "dark";

    base16Scheme = {
      slug = "kanagawa";
      scheme = "rebelot";
      author = "balsoft";
      base00 = "#000000";
      base01 = "#0d0c0c";
      base02 = "#2d4f67";
      base03 = "#a6a69c";
      base04 = "#7fb4ca";
      base05 = "#c5c9c5";
      base06 = "#938aa9";
      base07 = "#c5c9c5";

      base08 = "#c4746e";
      base09 = "#e46876";
      base0A = "#c4b28a";
      base0B = "#8a9a7b";
      base0C = "#8ea4a2";
      base0D = "#8ba4b0";
      base0E = "#a292a3";
      base0F = "#7aa89f";
    };

    targets.grub.enable = false;
    autoEnable = true;
    targets.gtk.enable = true;

    # Fonts
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka nerd font";
      };

    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
