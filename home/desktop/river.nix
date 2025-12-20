{ inputs, lib, config, pkgs, ... }: {
  imports = [ ];

  # stylix.targets.river.enable = true;
  #
  # wayland.windowManager.river = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # River configuration
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/bin/sh

      # Use rivercarro for layout (better than rivertile)
      riverctl default-layout rivertile
      riverctl default-layout rivercarro
      rivertile -view-padding 2 -outer-padding 2 -main-ratio 0.5 -main-count 1 &
      # rivercarro -inner-gaps 0 -outer-gaps 0 &

      # Set keyboard layout
      riverctl keyboard-layout dk

      # Set repeat rate
      riverctl set-repeat 50 300

      # Border configuration
      riverctl border-width 3
      riverctl border-color-focused 0x${config.lib.stylix.colors.base0D}
      riverctl border-color-unfocused 0x${config.lib.stylix.colors.base01}

      # Program launches
      riverctl map normal Alt B spawn firefox
      riverctl map normal Alt Space spawn "rofi -show drun -show-icons"
      riverctl map normal Alt T spawn thunar
      riverctl map normal Alt Return spawn ghostty
      riverctl map normal Super L spawn swaylock

      # Screenshots
      riverctl map normal Super+Shift S spawn 'grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +"%Y-%m-%d-%H%M%S_grim.png")'
      riverctl map normal Super+Control S spawn 'grim ~/Pictures/Screenshots/$(date +"%Y-%m-%d-%H%M%S_grim.png")'
      riverctl map normal None Print spawn 'grim ~/Pictures/Screenshots/$(date +"%Y-%m-%d-%H%M%S_grim.png")'

      # Window focus (vim keys)
      riverctl map normal Alt H focus-view left
      riverctl map normal Alt J focus-view down
      riverctl map normal Alt K focus-view up
      riverctl map normal Alt L focus-view right

      # Move windows (vim keys)
      riverctl map normal Alt+Shift H swap left
      riverctl map normal Alt+Shift J swap down
      riverctl map normal Alt+Shift K swap up
      riverctl map normal Alt+Shift L swap right

      # Snap views to screen edges
      # riverctl map normal Alt+Control H send-layout-cmd rivercarro "main-ratio -0.05"
      # riverctl map normal Alt+Control L send-layout-cmd rivercarro "main-ratio +0.05"
      # riverctl map normal Alt+Control K send-layout-cmd rivercarro "main-count +1"
      # riverctl map normal Alt+Control J send-layout-cmd rivercarro "main-count -1"

      # Window management
      riverctl map normal Alt Q close
      riverctl map normal Super F toggle-fullscreen
      riverctl map normal Alt Tab focus-view next
      riverctl map normal Alt+Shift Tab focus-view previous
      riverctl map normal Super Space toggle-float
      riverctl map normal Super T toggle-float

      # Tags (workspaces) - using your custom layout: x, c, v, s, d, f, w, e, r, z
      # Tag 1 (x)
      riverctl map normal Alt X set-focused-tags 1
      riverctl map normal Alt+Shift X set-view-tags 1

      # Tag 2 (c)
      riverctl map normal Alt C set-focused-tags 2
      riverctl map normal Alt+Shift C set-view-tags 2

      # Tag 3 (v)
      riverctl map normal Alt V set-focused-tags 4
      riverctl map normal Alt+Shift V set-view-tags 4

      # Tag 4 (s)
      riverctl map normal Alt S set-focused-tags 8
      riverctl map normal Alt+Shift S set-view-tags 8

      # Tag 5 (d)
      riverctl map normal Alt D set-focused-tags 16
      riverctl map normal Alt+Shift D set-view-tags 16

      # Tag 6 (f)
      riverctl map normal Alt F set-focused-tags 32
      riverctl map normal Alt+Shift F set-view-tags 32

      # Tag 7 (w)
      riverctl map normal Alt W set-focused-tags 64
      riverctl map normal Alt+Shift W set-view-tags 64

      # Tag 8 (e)
      riverctl map normal Alt E set-focused-tags 128
      riverctl map normal Alt+Shift E set-view-tags 128

      # Tag 9 (r)
      riverctl map normal Alt R set-focused-tags 256
      riverctl map normal Alt+Shift R set-view-tags 256

      # Tag 10 (z)
      riverctl map normal Alt Z set-focused-tags 512
      riverctl map normal Alt+Shift Z set-view-tags 512

      # Media keys
      riverctl map normal None XF86AudioRaiseVolume spawn 'wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+'
      riverctl map normal None XF86AudioLowerVolume spawn 'wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-'
      riverctl map normal None XF86AudioMute spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
      riverctl map normal None XF86AudioMicMute spawn 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'
      riverctl map normal None XF86MonBrightnessUp spawn 'brightnessctl s 10%+'
      riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl s 10%-'
      riverctl map normal None XF86AudioNext spawn 'playerctl next'
      riverctl map normal None XF86AudioPause spawn 'playerctl play-pause'
      riverctl map normal None XF86AudioPlay spawn 'playerctl play-pause'
      riverctl map normal None XF86AudioPrev spawn 'playerctl previous'

      # Mouse bindings
      riverctl map-pointer normal Alt BTN_LEFT move-view
      riverctl map-pointer normal Alt BTN_RIGHT resize-view

      # Window rules
      riverctl rule-add -app-id "firefox" -title "Picture-in-Picture" float
      riverctl rule-add -title "Save File" float
      riverctl rule-add -title "Torrent Options" float
      riverctl rule-add -title "Firefox*Sharing Indicator" float

      # Make all views with app-id "bar" use client-side decorations
      riverctl rule-add -app-id "bar" csd

      # Set cursor theme
      riverctl xcursor-theme default 24

      # Startup programs
      waybar &
      systemctl --user start swww &
      systemctl --user start set-wallpaper &
    '';
  };


}

