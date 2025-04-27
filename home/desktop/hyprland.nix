{ inputs, lib, config, pkgs, ... }: {
  imports = [ ];

  stylix.targets.hyprland.enable = true;

  # Extra "inventory space"
  home.sessionVariables = { HYPRLAND_INVENTORY = 1; };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [ ",preferred,auto,auto" ];
      xwayland.force_zero_scaling = true;
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float, title:^(Firrfox — Sharing Indicator)$"
        "noborder, title:^(Firefox — Sharing Indicator)$"
        "rounding 0, title:^(Firefox — Sharing Indicator)$"
        "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "pin, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "move 100%-w-20 100%-w-20, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "float, title:^(Save File)$"
        "pin, title:^(Save File)$"
        "pin, class:^(dragon)$"
        "float, title:^(Torrent Options)$"
        "pin, title:^(Torrent Options)$"
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        # "noborder,focus:0"
      ];
      general = {
        # Borders etc
        border_size = 3;
        gaps_in = 0;
        gaps_out = 0;
        # col.inactive_border = "0xff000000"; #rgb(${base02});
      };
      # Decoration
      decoration = {
        rounding = 0;
        inactive_opacity = 1.0;
        blur.size = 20;
      };

      input = {
        kb_layout = "dk";

        follow_mouse = 1;

        touchpad.natural_scroll = false;
      };
      "$mod" = "ALT";
      "$secondMod" = "SUPER";
      exec-once = [
        "waybar"
        "hyprpaper"
        "hypridle"
        "systemctl --user start swww"
        "systemctl --user start set-wallpaper"
      ];
      # Mouse Binds
      bindm = [
        # Window
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      # Keybinds
      bindel = [
        # Utility
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XFl86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        # # Window rules
        # "$mod CONTROL, h, resizeactive, -50 0"
        # "$mod CONTROL, j, resizeactive, 0 50"
        # "$mod CONTROL, k, resizeactive, 0 -50"
        # "$mod CONTROL, l, resizeactive, 50 0"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindr = [
        # "Windows key"
        "$mod, O, exec, tofi-drun --drun-launch=true"
      ];
      bind = [
        # Program rules
        "$mod, B, exec, firefox"
        "$mod, SPACE, exec, rofi -show drun -show-icons"
        # "$mod, SPACE, exec, wofi --show drun"
        "$mod, T, exec, thunar"
        "$mod, RETURN, exec, kitty"
        "$secondMod, L, exec, hyprlock"

        # Utility
        "$secondMod SHIFT, S, exec, hyprshot -m region -o ~/Pictures/Screenshots/"
        "$secondMod CONTROL, S, exec, hyprshot -m window -o ~/Pictures/Screenshots/"
        ", Print, exec, hyprshot -m output -o ~/Pictures/Screenshots/"

        # Window Rules
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # "$mod, c, centerwindow, 1"

        "$secondMod, q, killactive"
        "$secondMod, f, fullscreen, 0"
        "$secondMod, f, fullscreen, 1"
        "$mod, tab, cyclenext"
        "$mod SHIFT, tab, cyclenext, prev"
        "$secondMod, SPACE, togglefloating"

        "$mod, x, workspace, 1"
        "$mod, c, workspace, 2"
        "$mod, v, workspace, 3"
        "$mod, s, workspace, 4"
        "$mod, d, workspace, 5"
        "$mod, f, workspace, 6"
        "$mod, w, workspace, 7"
        "$mod, e, workspace, 8"
        "$mod, r, workspace, 9"
        "$mod, z, workspace, 10"

        "$mod SHIFT, x, movetoworkspace, 1"
        "$mod SHIFT, c, movetoworkspace, 2"
        "$mod SHIFT, v, movetoworkspace, 3"
        "$mod SHIFT, s, movetoworkspace, 4"
        "$mod SHIFT, d, movetoworkspace, 5"
        "$mod SHIFT, f, movetoworkspace, 6"
        "$mod SHIFT, w, movetoworkspace, 7"
        "$mod SHIFT, e, movetoworkspace, 8"
        "$mod SHIFT, r, movetoworkspace, 9"
        "$mod SHIFT, z, movetoworkspace, 10"
        # Workspace rules
        # "$mod, bracketright, workspace, +1"
        # "$mod, bracketleft, workspace, -1"
        # "$mod, SPACE, togglespecialworkspace"
        # "$mod SHIFT, SPACE, movetoworkspace, special"
      ];
      # ++ (
      # # workspaces
      # # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      # builtins.concatLists (builtins.genList
      #   (x:
      #     let
      #       ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
      #     in
      #     [
      #       "$mod, ${ws}, workspace, ${toString (x + 1)}"
      #       "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      #     ]) 10));

      animations = {
        enabled = 1;
        bezier = "overshot,0.13,0.99,0.29,1.1,";
        animation = [
          "fade,1,4,default"
          "workspaces,1,4,default,fade"
          "windows,1,4,overshot,popin 95%"
        ];
      };

      # Miscallaneous settings
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        # background_color = "0x26233a";
      };
    };
  };
}
