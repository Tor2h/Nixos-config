{ lib, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 42;
        modules-left = [
          "mpris"
        ];
        # Use multiple workspace modules - waybar will automatically show the active one
        modules-center = [
          "hyprland/workspaces"
          "sway/workspaces"
          "river/tags" # Mango uses river protocol
          "ext/workspaces"
          "dwl/tags"
        ];
        modules-right = [
          "clock"
          "pulseaudio"
          "custom/backlight"
          "cpu"
          "memory"
          "network"
          "tray"
          "custom/power"
        ];

        "mpris" = {
          "title-len" = 40;
          "interval" = 1;
          "album-len" = 0;
          "max-len" = 60;
          "max-empty-time" = 60;
          "format" = "{player_icon} {artist} - {title}";
          "format-paused" = "{player_icon} {artist} - {title}";
          "player-icons" = {
            "default" = "▶";
            "mpv" = "🎵";
            "firefox" = "";
          };
          "status-icons" = {
            "paused" = "";
          };
          # "ignored-players" = [ "librewolf" "vlc" "firefox" "brave" ];
        };

        "mpd" = {
          "format" = "{stateIcon} {artist} - {title}";
          "format-disconnected" = "Disconnected ";
          "format-stopped" = "{stateIcon} {artist} - {title}";
          # "format-stopped" = "";
          "format-empty" = "";
          "interval" = 1;
          "on-click" = "mpc toggle";
          "consume-icons" = {
            "on" = " "; # Icon shows only when "consume" is on
          };
          "repeat-icons" = {
            "on" = " ";
          };
          "single-icons" = {
            "on" = " 1 ";
          };
          "state-icons" = {
            "paused" = " ";
            "playing" = " ";
          };
          "tooltip-format" = "MPD (connected)";
          "tooltip-format-disconnected" = "MPD (disconnected)";
        };

        "clock" = {
          "format" = "󰃭  {:%d/%m   %H:%M}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        # Hyprland workspaces
        "hyprland/workspaces" = {
          format = "{name}";
          tooltip = "true";
          all-outputs = false;
          sort-by-number = true;
          persistent-workspaces = { };
        };

        # Sway workspaces
        "sway/workspaces" = {
          format = "{name}";
          disable-scroll = false;
          all-outputs = false;
          sort-by-number = true;
          persistent-workspaces = { };
        };

        # River tags (for Mango/river-based compositors)
        "river/tags" = {
          num-tags = 10;
          hide-vacant = true;
        };

        "ext/workspaces" = {
          "format" = "{icon}";
          "ignore-hidden" = false;
          "on-click" = "activate";
          "on-click-right" = "deactivate";
          "sort-by-id" = true;
        };

        "dwl/tags" = {
          "num-tags" = 9;
        };

        "tray" = {
          "icon-size" = 20;
          "spacing" = 5;
        };

        "network" = {
          format-icons = [
            "󰤯 "
            "󰤟 "
            "󰤢 "
            "󰤥 "
            "󰤨 "
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };

        "custom/backlight" = {
          exec = "ddcutil -b 10 getvcp 10 -t | perl -nE 'if (/ C (\\d+) /) { say $1; }'";
          exec-if = "sleep 1";
          format = "{icon} {}%";
          format-icons = [ "" ];
          # return-type = "json";
          # exec = "ddcutil --bus 8 getvcp 10 | grep -oP 'current.*?=\\s*\\K[0-9]+' | { read x; echo \"{\\\"percentage\\\":$x}\"; }";
          on-scroll-up = "ddcutil --noverify --bus 10 setvcp 10 + 5";
          on-scroll-down = "ddcutil --noverify --bus 10 setvcp 10 - 5";
          on-click = "ddcutil --noverify --bus 10 setvcp 10 + 10";
          on-click-right = "ddcutil --noverify --bus 10 setvcp 10 - 10";
          interval = "once";
          tooltip = false;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          on-click = "pavucontrol -t 3";
          on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
              "󰕾"
              "󰕾"
              "󰕾"
              ""
              ""
              ""
            ];
          };
        };

        "cpu" = {
          interval = 1;
          format = "  {}%";
        };

        "memory" = {
          interval = 1;
          format = "  {}%";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "󰐥";
        };
      };
    };

    style = lib.mkAfter ''
          * {
                  border: none;
                  font-family :  'Iosevka nerd font', 'FiraCode Nerd Font', 'Symbols Nerd Font Mono';
                  font-size: 20px;
                  font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
                  min-height: 20px;
                }

                window#waybar {
                }

                #mpris,
                #clock,
                #pulseaudio,  
                #custom-backlight,
                #cpu,
                #memory,
                #network,
                #tray,
                #custom-power
                {
                  border-radius: 5px;
                  padding-left: 0px;
                  padding-right: 0px;
                  margin-top: 0px;
                  margin-right: 10px;
                  margin-bottom: 0px;
                  color: @base0D;
                }

                #clock, #custom-backlight {
                  padding-right: 20px;
                  margin-right: 20px;
                  border-right: 1px solid @base0D;
                  margin-top: 5px;
                  margin-bottom: 5px;
                }

                #custom-power {
                  margin-left: 10px;
                  padding-left: 20px;
                  border-left: 1px solid @base0D;
                  margin-top: 5px;
                  margin-bottom: 5px;
                  margin-right: 20px;
                }

                #tray {
                  margin-left: 10px;
                  padding-left: 20px;
                  border-left: 1px solid @base0D;
                  margin-top: 5px;
                  margin-bottom: 5px;
                }

                #mpris {
                  margin-left: 20px;
                }

                #workspaces {
                  padding: 0px 0px;
                }

                #workspaces button {
                  margin-left: 5px;
                  margin-bottom: 5px;
                  background: @base01;
                  color: @base0D;
                }

                 #workspaces button.active {
                  background: @base0D;
                  color: @base01;
      }

      /* Shared styles for all workspace modules */
      #workspaces,
      .modules-center > * {
        padding: 0px 0px;
      }

      /* Hyprland workspaces */
      #workspaces.hyprland button,
      /* Sway workspaces */
      #workspaces.sway button,
      /* River tags */
      #tags button {
        margin-left: 5px;
        margin-bottom: 5px;
        background: @base0D;
        color: @base01;
      }

      #workspaces.hyprland button.active,
      #workspaces.sway button.focused,
      #workspaces.ext button.active,
      #tags button.focused {
        background: @base0D;
        color: @base01;
      }

      #workspaces button.persistent {
      }

      #workspaces button {
      }
    '';
  };
}
