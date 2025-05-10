{ lib
, ...
}:

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
        modules-center = [ "hyprland/workspaces" ];
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
            "spotify" = " ";
            "spotify-player" = " ";
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
          "format" = "󰃭  {:%m/%d   %H:%M}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          tooltip = "true";
          all-outputs = false; # Required for persistent-workspaces to work
          sort-by-number = true;
          persistent-workspaces = { };
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
          exec = "ddcutil -b 8 getvcp 10 -t | perl -nE 'if (/ C (\\d+) /) { say $1; }'";
          exec-if = "sleep 1";
          format = "{icon} {}%";
          format-icons = [ "" ];
          interval = "once";
          on-scroll-up = "ddcutil setvcp 10 + 5";
          on-scroll-down = "ddcutil setvcp 10 - 5";
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
                  color: @base06;
                }

                #clock, #custom-backlight {
                  padding-right: 20px;
                  margin-right: 20px;
                  border-right: 1px solid @base06;
                  margin-top: 5px;
                  margin-bottom: 5px;
                }

                #custom-power {
                  margin-left: 10px;
                  padding-left: 20px;
                  border-left: 1px solid @base06;
                  margin-top: 5px;
                  margin-bottom: 5px;
                  margin-right: 20px;
                }

                #tray {
                  margin-left: 10px;
                  padding-left: 20px;
                  border-left: 1px solid @base06;
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
                  color: @base06;
                }

                 #workspaces button.active {
                  background: @base06;
                  color: @base01;
      }
      #workspaces button.persistent {
      }
      #workspaces button {
      }
    '';
  };
}
