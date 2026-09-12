{lib, ...}: {
  flake.wrappers.niri = {
    pkgs,
    wlib,
    ...
  }: let
    bgdark = "#0b0e14";
    bglight = "#202229";
    active = "#95e6cb";
    urgent = "#ff8f40";
    recording = "#f07178";

    file-manager = lib.getExe pkgs.nautilus;
    terminal = lib.getExe pkgs.alacritty;
    launcher = lib.getExe pkgs.fuzzel;
    lock-screen = lib.getExe pkgs.hyprlock;
    playerctl = lib.getExe pkgs.playerctl;
    swaync-client = lib.getExe' pkgs.swaynotificationcenter "swaync-client";
    swayosd-client = lib.getExe' pkgs.swayosd "swayosd-client";
  in {
    imports = [wlib.wrapperModules.niri];

    runtimePkgs = with pkgs; [xwayland-satellite];

    settings = let
      yep = _: {};
    in {
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = yep;

      outputs = {
        # Dell XPS 13 built-in display.
        "Sharp Corporation 0x1449 Unknown".scale = 1.0;

        # G9 Odyssey.
        "Samsung Electric Company LS49AG95 HNTRB00272" = {
          layout = {
            default-column-width.proportion = 0.33333;
            preset-column-widths = [
              {proportion = 0.25;}
              {proportion = 0.33333;}
              {proportion = 0.5;}
              {proportion = 0.66667;}
            ];
          };
        };
      };

      environment = {
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "niri";
        XDG_CURRENT_DESKTOP = "niri";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      layout = {
        gaps = 8;
        struts = {
          left = 8;
          right = 8;
          top = 8;
          bottom = 8;
        };

        background-color = "transparent";

        always-center-single-column = true;

        default-column-width.proportion = 0.5;
        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        preset-window-heights = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
          {proportion = 1.0;}
        ];

        focus-ring.off = yep;
        border = {
          on = yep;
          width = 2;
          active-color = active;
          inactive-color = bglight;
          urgent-color = urgent;
        };

        shadow.on = yep;

        tab-indicator = {
          width = 8;
          length = _: {props.total-proportion = 0.5;};
          gap = 8;
          gaps-between-tabs = 8;
          place-within-column = true;
          corner-radius = 8.0;
        };
      };

      overview = {
        backdrop-color = bgdark;
        workspace-shadow.off = yep;
      };

      layer-rules = [
        {
          matches = [{namespace = "^launcher$";}];
          shadow.on = yep;
        }
        {
          matches = [{namespace = "^wallpaper$";}];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          geometry-corner-radius = 16;
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
          default-floating-position = _: {
            props.x = 8;
            props.y = 8;
            props.relative-to = "bottom-right";
          };
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          open-focused = false;
          geometry-corner-radius = 0;
          default-floating-position = _: {
            props.x = 0;
            props.y = 0;
            props.relative-to = "bottom-right";
          };
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^Friends List$";
            }
          ];
          default-column-width = {fixed = 400;};
        }
        {
          matches = [{app-id = "^org\.gnome\.Calculator$";}];
          open-floating = true;
        }
        {
          matches = [{is-floating = true;}];
          shadow.on = yep;
        }
        {
          matches = [{is-window-cast-target = true;}];
          border.inactive-color = recording;
          shadow = {
            on = yep;
            color = "${recording}b0";
          };
        }
        {
          matches = [{is-urgent = true;}];
          shadow = {
            on = yep;
            color = "${urgent}b0";
          };
        }
      ];

      input = {
        keyboard = {
          numlock = yep;
          repeat-delay = 200;
          repeat-rate = 20;
        };
        touchpad = {
          tap = yep;
          dwt = yep;
          natural-scroll = yep;
        };
        mouse = {
          accel-speed = 0.1;
          accel-profile = "flat";
        };
        warp-mouse-to-focus = yep;
      };
      gestures.hot-corners.off = yep;

      binds = {
        "Mod+Shift+Slash".show-hotkey-overlay = yep;

        "Mod+E" = _: {
          props.hotkey-overlay-title = "Open file manager";
          content.spawn = file-manager;
        };
        "Mod+N" = _: {
          props.hotkey-overlay-title = "Toggle notifications";
          content.spawn = [swaync-client "--toggle-panel"];
        };
        "Mod+T" = _: {
          props.hotkey-overlay-title = "Open terminal";
          content.spawn = terminal;
        };
        "Mod+Space" = _: {
          props.hotkey-overlay-title = "Open launcher";
          content.spawn = launcher;
        };
        "Super+Alt+L" = _: {
          props.hotkey-overlay-title = "Lock screen";
          content.spawn-sh = "${lock-screen} & niri msg action power-off-monitors";
        };

        XF86AudioPrev.spawn = [playerctl "previous"];
        XF86AudioPlay.spawn = [playerctl "play-pause"];
        XF86AudioNext.spawn = [playerctl "next"];

        XF86AudioRaiseVolume = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--output-volume" "raise"];
        };
        XF86AudioLowerVolume = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--output-volume" "lower"];
        };
        XF86AudioMute = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--output-volume" "mute-toggle"];
        };
        XF86AudioMicMute = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--input-volume" "mute-toggle"];
        };

        XF86MonBrightnessUp = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--brightness" "raise"];
        };
        XF86MonBrightnessDown = _: {
          props.allow-when-locked = true;
          content.spawn = [swayosd-client "--brightness" "lower"];
        };

        "Mod+B" = _: {
          props.repeat = false;
          props.hotkey-overlay-title = "Toggle bar";
          content.spawn = ["pkill" "-SIGUSR1" "waybar"];
        };

        "Mod+O" = _: {
          props.repeat = false;
          content.toggle-overview = yep;
        };

        "Mod+Q" = _: {
          props.repeat = false;
          content.close-window = yep;
        };

        "Mod+Left".focus-column-left = yep;
        "Mod+Down".focus-window-down = yep;
        "Mod+Up".focus-window-up = yep;
        "Mod+Right".focus-column-right = yep;
        "Mod+H".focus-column-left = yep;
        "Mod+J".focus-window-down = yep;
        "Mod+K".focus-window-up = yep;
        "Mod+L".focus-column-right = yep;

        "Mod+Ctrl+Left".move-column-left = yep;
        "Mod+Ctrl+Down".move-window-down = yep;
        "Mod+Ctrl+Up".move-window-up = yep;
        "Mod+Ctrl+Right".move-column-right = yep;
        "Mod+Ctrl+H".move-column-left = yep;
        "Mod+Ctrl+J".move-window-down = yep;
        "Mod+Ctrl+K".move-window-up = yep;
        "Mod+Ctrl+L".move-column-right = yep;

        "Mod+Home".focus-column-first = yep;
        "Mod+End".focus-column-last = yep;
        "Mod+Ctrl+Home".move-column-to-first = yep;
        "Mod+Ctrl+End".move-column-to-last = yep;

        "Mod+Shift+Left".focus-monitor-left = yep;
        "Mod+Shift+Down".focus-monitor-down = yep;
        "Mod+Shift+Up".focus-monitor-up = yep;
        "Mod+Shift+Right".focus-monitor-right = yep;
        "Mod+Shift+H".focus-monitor-left = yep;
        "Mod+Shift+J".focus-monitor-down = yep;
        "Mod+Shift+K".focus-monitor-up = yep;
        "Mod+Shift+L".focus-monitor-right = yep;

        "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = yep;
        "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = yep;
        "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = yep;
        "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = yep;
        "Mod+Shift+Ctrl+H".move-column-to-monitor-left = yep;
        "Mod+Shift+Ctrl+J".move-column-to-monitor-down = yep;
        "Mod+Shift+Ctrl+K".move-column-to-monitor-up = yep;
        "Mod+Shift+Ctrl+L".move-column-to-monitor-right = yep;

        "Mod+Page_Down".focus-workspace-down = yep;
        "Mod+Page_Up".focus-workspace-up = yep;
        "Mod+U".focus-workspace-down = yep;
        "Mod+I".focus-workspace-up = yep;
        "Mod+Ctrl+Page_Down".move-column-to-workspace-down = yep;
        "Mod+Ctrl+Page_Up".move-column-to-workspace-up = yep;
        "Mod+Ctrl+U".move-column-to-workspace-down = yep;
        "Mod+Ctrl+I".move-column-to-workspace-up = yep;

        "Mod+Shift+Page_Down".move-workspace-down = yep;
        "Mod+Shift+Page_Up".move-workspace-up = yep;
        "Mod+Shift+U".move-workspace-down = yep;
        "Mod+Shift+I".move-workspace-up = yep;

        "Mod+WheelScrollDown" = _: {
          props.cooldown-ms = 150;
          content.focus-workspace-down = yep;
        };
        "Mod+WheelScrollUp" = _: {
          props.cooldown-ms = 150;
          content.focus-workspace-up = yep;
        };
        "Mod+Ctrl+WheelScrollDown" = _: {
          props.cooldown-ms = 150;
          content.move-column-to-workspace-down = yep;
        };
        "Mod+Ctrl+WheelScrollUp" = _: {
          props.cooldown-ms = 150;
          content.move-column-to-workspace-up = yep;
        };

        "Mod+WheelScrollRight".focus-column-right = yep;
        "Mod+WheelScrollLeft".focus-column-left = yep;
        "Mod+Ctrl+WheelScrollRight".move-column-right = yep;
        "Mod+Ctrl+WheelScrollLeft".move-column-left = yep;

        "Mod+Shift+WheelScrollDown".focus-column-right = yep;
        "Mod+Shift+WheelScrollUp".focus-column-left = yep;
        "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = yep;
        "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = yep;

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;
        "Mod+Ctrl+1".move-column-to-workspace = 1;
        "Mod+Ctrl+2".move-column-to-workspace = 2;
        "Mod+Ctrl+3".move-column-to-workspace = 3;
        "Mod+Ctrl+4".move-column-to-workspace = 4;
        "Mod+Ctrl+5".move-column-to-workspace = 5;
        "Mod+Ctrl+6".move-column-to-workspace = 6;
        "Mod+Ctrl+7".move-column-to-workspace = 7;
        "Mod+Ctrl+8".move-column-to-workspace = 8;
        "Mod+Ctrl+9".move-column-to-workspace = 9;

        "Mod+BracketLeft".consume-or-expel-window-left = yep;
        "Mod+BracketRight".consume-or-expel-window-right = yep;

        "Mod+Comma".consume-window-into-column = yep;
        "Mod+Period".expel-window-from-column = yep;

        "Mod+R".switch-preset-column-width = yep;
        "Mod+Shift+R".switch-preset-window-height = yep;
        "Mod+Ctrl+R".reset-window-height = yep;
        "Mod+F".maximize-window-to-edges = yep;
        "Mod+Shift+F".fullscreen-window = yep;
        "Mod+Ctrl+F".expand-column-to-available-width = yep;
        "Mod+Alt+F".toggle-windowed-fullscreen = yep;

        "Mod+C".center-column = yep;
        "Mod+Ctrl+C".center-visible-columns = yep;

        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";

        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        "Mod+Ctrl+V".toggle-window-floating = yep;
        "Mod+V".switch-focus-between-floating-and-tiling = yep;

        "Mod+W".toggle-column-tabbed-display = yep;

        "Print".screenshot = yep;
        "Ctrl+Print".screenshot-screen = yep;
        "Alt+Print".screenshot-window = yep;

        "Mod+Escape" = _: {
          props.allow-inhibiting = false;
          content.toggle-keyboard-shortcuts-inhibit = yep;
        };

        "Mod+Shift+E".quit = yep;
        "Ctrl+Alt+Delete".quit = yep;

        "Mod+Shift+P".power-off-monitors = yep;
      };
    };
  };
}
