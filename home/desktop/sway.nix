{ inputs, lib, config, pkgs, ... }: {
  imports = [ ];

  stylix.targets.sway.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    extraOptions = [ "--unsupported-gpu" ];

    config = rec {
      modifier = "Mod1"; # Alt key

      bars = [ ];

      # Terminal
      terminal = "ghostty";

      # Menu/Launcher
      menu = "rofi -show drun -show-icons";

      # Startup programs
      startup = [
        # { command = "waybar"; }
        { command = "autotiling"; }
        { command = "systemctl --user start swww"; }
        { command = "systemctl --user start set-wallpaper"; }
      ];

      # Monitor configuration
      output = {
        "*" = {
          scale = "1";
        };
      };

      # Input configuration
      input = {
        "*" = {
          xkb_layout = "dk";
        };
        "type:touchpad" = {
          natural_scroll = "disabled";
        };
      };

      # Window rules
      window = {
        titlebar = false;
        border = 3;
      };

      # Gaps
      gaps = {
        inner = 0;
        outer = 0;
      };

      # Colors (using stylix)
      colors = {
        focused = {
          # border = "#${config.lib.stylix.colors.base0D}";
          # background = "#${config.lib.stylix.colors.base00}";
          # text = "#${config.lib.stylix.colors.base05}";
          # indicator = "#${config.lib.stylix.colors.base0D}";
          # childBorder = "#${config.lib.stylix.colors.base0D}";
        };
        unfocused = {
          # border = "#${config.lib.stylix.colors.base01}";
          # background = "#${config.lib.stylix.colors.base00}";
          # text = "#${config.lib.stylix.colors.base03}";
          # indicator = "#${config.lib.stylix.colors.base01}";
          # childBorder = "#${config.lib.stylix.colors.base01}";
        };
      };

      # Keybindings
      keybindings = lib.mkOptionDefault {
        # Program launches
        "${modifier}+b" = "exec firefox";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+t" = "exec thunar";
        "${modifier}+Return" = "exec ${terminal}";
        "Mod4+l" = "exec swaylock"; # Super+L for lock

        # Screenshots
        "Mod4+Shift+s" = "exec grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')";
        "Mod4+Control+s" = "exec grim -g \"$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"')\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')";
        "Print" = "exec grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')";

        # Window focus (vim keys)
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        # Move windows (vim keys)
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        # Resize windows
        "${modifier}+Control+h" = "resize shrink width 50px";
        "${modifier}+Control+l" = "resize grow width 50px";
        "${modifier}+Control+j" = "resize grow height 50px";
        "${modifier}+Control+k" = "resize shrink height 50px";

        # Window management
        "${modifier}+q" = "kill";
        "Mod4+f" = "fullscreen toggle";
        "${modifier}+Tab" = "focus next";
        "${modifier}+Shift+Tab" = "focus prev";
        "Mod4+space" = "floating toggle";
        "Mod4+t" = "floating disable";

        # Workspaces (using your custom layout)
        "${modifier}+x" = "workspace number 1";
        "${modifier}+c" = "workspace number 2";
        "${modifier}+v" = "workspace number 3";
        "${modifier}+s" = "workspace number 4";
        "${modifier}+d" = "workspace number 5";
        "${modifier}+f" = "workspace number 6";
        "${modifier}+w" = "workspace number 7";
        "${modifier}+e" = "workspace number 8";
        "${modifier}+r" = "workspace number 9";
        "${modifier}+z" = "workspace number 10";

        # Move to workspaces
        "${modifier}+Shift+x" = "move container to workspace number 1";
        "${modifier}+Shift+c" = "move container to workspace number 2";
        "${modifier}+Shift+v" = "move container to workspace number 3";
        "${modifier}+Shift+s" = "move container to workspace number 4";
        "${modifier}+Shift+d" = "move container to workspace number 5";
        "${modifier}+Shift+f" = "move container to workspace number 6";
        "${modifier}+Shift+w" = "move container to workspace number 7";
        "${modifier}+Shift+e" = "move container to workspace number 8";
        "${modifier}+Shift+r" = "move container to workspace number 9";
        "${modifier}+Shift+z" = "move container to workspace number 10";

        # Media keys
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl s 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPrev" = "exec playerctl previous";
      };

      # Mouse bindings
      floating = {
        modifier = "${modifier}";
        # Left click to move, right click to resize
      };
    };

    extraConfig = ''
      # Window rules (similar to Hyprland windowrulev2)
      for_window [title="Firefox — Sharing Indicator"] floating enable, border none
      for_window [app_id="firefox" title="Picture-in-Picture"] floating enable, sticky enable
      for_window [title="Save File"] floating enable, sticky enable
      for_window [app_id="dragon"] sticky enable
      for_window [title="Torrent Options"] floating enable, sticky enable
      for_window [app_id="xwaylandvideobridge"] opacity 0, floating enable, nofocus

      # Disable window borders when only one window
      # smart_borders on
      
      # No rounding (Sway doesn't support rounded corners natively)
    '';
  };
}
