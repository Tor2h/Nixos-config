-- hyprland.lua
-- Migrated from hyprlang (NixOS home-manager settings) to Lua (Hyprland 0.55+)
-- Place this file at ~/.config/hypr/hyprland.lua
-- In your NixOS config, replace wayland.windowManager.hyprland.settings with:
--   home.file.".config/hypr/hyprland.lua".source = ./hyprland.lua;
-- (Stylix border colors are hardcoded below — update them to match your theme's base0D/base01)

local mod       = "ALT"
local secondMod = "SUPER"

-- ─── Monitor ─────────────────────────────────────────────────────────────────
hl.monitor({
  output   = "", -- empty = all/default monitor
  mode     = "2560x1440@165",
  position = "auto",
  scale    = 1,
})

-- ─── General config ───────────────────────────────────────────────────────────
hl.config({
  xwayland = {
    force_zero_scaling = true,
  },

  general = {
    border_size = 3,
    gaps_in     = 0,
    gaps_out    = 0,
    -- Replace these hex values with your Stylix base0D/base01 colors:
    col         = {
      active_border   = "rgb(8ba4b0)", -- was config.lib.stylix.colors.base0D
      inactive_border = "rgb(0d0c0c)", -- was config.lib.stylix.colors.base01
    },
  },

  decoration = {
    rounding         = 0,
    inactive_opacity = 1.0,
    blur             = { size = 20 },
  },

  input = {
    kb_layout    = "dk",
    follow_mouse = 1,
    touchpad     = { natural_scroll = true },
  },

  animations = {
    enabled = true,
  },

  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
  },
})

-- ─── Animations ──────────────────────────────────────────────────────────────
hl.curve("fade", { type = "bezier", points = { { 0.79, 0.33 }, { 0.14, 0.53 } } })

hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "fade" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "fade", style = "popin 95%" })

-- ─── Window Rules ────────────────────────────────────────────────────────────
hl.window_rule({ match = { class = ".*" }, maximize = false })

hl.window_rule({
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  stay_focused = false,
})

-- Firefox sharing indicator
hl.window_rule({ match = { title = "^Firefox — Sharing Indicator$" }, float = true })
hl.window_rule({ match = { title = "^Firefox — Sharing Indicator$" }, rounding = 0 })

-- Firefox Picture-in-Picture
hl.window_rule({ match = { class = "^firefox$", title = "^Picture%-in%-Picture$" }, float = true })
hl.window_rule({ match = { class = "^firefox$", title = "^Picture%-in%-Picture$" }, pin = true })
hl.window_rule({ match = { class = "^firefox$", title = "^Picture%-in%-Picture$" }, move = { "100%-w-20", "100%-w-20" } })

-- Save File dialog
hl.window_rule({ match = { title = "^Save File$" }, float = true })
hl.window_rule({ match = { title = "^Save File$" }, pin = true })

-- Dragon (drag-and-drop)
hl.window_rule({ match = { class = "^dragon$" }, pin = true })

-- Torrent Options
hl.window_rule({ match = { title = "^Torrent Options$" }, float = true })
hl.window_rule({ match = { title = "^Torrent Options$" }, pin = true })

-- xwaylandvideobridge (invisible helper window)
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, opacity = "0.0 override 0.0 override" })
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, no_anim = true })
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, max_size = { 1, 1 } })
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, no_blur = true })

-- ─── Autostart ───────────────────────────────────────────────────────────────
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- ─── Program Launches ────────────────────────────────────────────────────────
hl.bind(mod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(secondMod .. " + period", hl.dsp.exec_cmd("smile"))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind(secondMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(secondMod .. " + V",
  hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

-- ─── Screenshots ─────────────────────────────────────────────────────────────
hl.bind(secondMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))
hl.bind(secondMod .. " + CONTROL + S", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots/"))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots/"))

-- ─── Focus Movement ──────────────────────────────────────────────────────────
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))

-- ─── Move Windows ────────────────────────────────────────────────────────────
hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))

-- ─── Window Management ───────────────────────────────────────────────────────
hl.bind(mod .. " + q", hl.dsp.window.close())
hl.bind(secondMod .. " + f", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mod .. " + tab", hl.dsp.window.cycle_next())
hl.bind(mod .. " + SHIFT + tab", hl.dsp.window.cycle_next({ prev = true }))
hl.bind(secondMod .. " + t", hl.dsp.window.float())

hl.bind(secondMod .. " + SPACE", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.resize({ x = 1500, y = 1200 }))
  hl.dispatch(hl.dsp.window.center())
end)

-- ─── Resize Windows (repeating) ──────────────────────────────────────────────
hl.bind(mod .. " + CONTROL + h", function()
  hl.dispatch(hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
  hl.dispatch(hl.dsp.window.center())
end, { repeating = true })
hl.bind(mod .. " + CONTROL + l", function()
  hl.dispatch(hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
  hl.dispatch(hl.dsp.window.center())
end, { repeating = true })
hl.bind(mod .. " + CONTROL + j", function()
  hl.dispatch(hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
  hl.dispatch(hl.dsp.window.center())
end, { repeating = true })
hl.bind(mod .. " + CONTROL + k", function()
  hl.dispatch(hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
  hl.dispatch(hl.dsp.window.center())
end, { repeating = true })

-- ─── Workspaces ──────────────────────────────────────────────────────────────
local wsKeys = {
  { key = "x", ws = 1 },
  { key = "c", ws = 2 },
  { key = "v", ws = 3 },
  { key = "s", ws = 4 },
  { key = "d", ws = 5 },
  { key = "f", ws = 6 },
  { key = "w", ws = 7 },
  { key = "e", ws = 8 },
  { key = "r", ws = 9 },
  { key = "z", ws = 10 },
}

for _, entry in ipairs(wsKeys) do
  hl.bind(mod .. " + " .. entry.key, hl.dsp.focus({ workspace = entry.ws }))
  hl.bind(mod .. " + SHIFT + " .. entry.key, hl.dsp.window.move({ workspace = entry.ws, true }))
end

-- ─── Mouse Binds ─────────────────────────────────────────────────────────────
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

-- ─── Audio / Media ───────────────────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
