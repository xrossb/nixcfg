{
  config,
  inputs,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix

    ./fuzzel.nix
    ./hyprlock.nix
    ./mako.nix
    ./polkit.nix
    ./swaybg.nix
    ./swayosd.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [xwayland-satellite];

  programs.niri = {
    package = pkgs.niri;
    settings = {
      outputs."Sharp Corporation 0x1449 Unknown".scale = 1.0;

      environment = {
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "niri";
        XDG_CURRENT_DESKTOP = "niri";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      input = {
        keyboard.numlock = true;

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };

        mouse = {
          accel-speed = 0.1;
          accel-profile = "flat";
        };
      };

      gestures.hot-corners.enable = false;

      layout = {
        gaps = 4;
        background-color = "transparent";
        always-center-single-column = true;

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        default-column-width.proportion = 0.5;

        preset-window-heights = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        focus-ring = {
          width = 1;
          active.gradient = {
            from = colors.base0C;
            to = colors.base0D;
            angle = 45;
          };
        };

        tab-indicator = {
          width = 8;
          length.total-proportion = 1.0;
          gap = 4;
          gaps-between-tabs = 4;
          place-within-column = true;
        };
      };

      overview.workspace-shadow.enable = false;

      layer-rules = [
        {
          matches = [{namespace = "^launcher$";}];
          shadow.enable = true;
        }
        {
          matches = [{namespace = "^wallpaper$";}];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          matches = [{app-id = "firefox$";}];
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
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          open-focused = false;
          default-floating-position = {
            x = 0;
            y = 0;
            relative-to = "bottom-right";
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
          shadow.enable = true;
        }
        {
          matches = [{is-window-cast-target = true;}];
          border = {
            enable = true;
            width = 1;
            inactive.color = colors.base08;
          };
          shadow = {
            enable = true;
            color = "${colors.base08}b0";
          };
        }
        {
          matches = [{is-urgent = true;}];
          border = {
            enable = true;
            width = 1;
            urgent.color = colors.base09;
          };
          shadow = {
            enable = true;
            color = "${colors.base09}b0";
          };
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+T".action = spawn "alacritty";
        "Mod+Space".action = spawn "fuzzel";
        "Super+Alt+L".action = spawn "hyprlock";

        XF86AudioRaiseVolume = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--output-volume" "raise";
        };
        XF86AudioLowerVolume = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--output-volume" "lower";
        };
        XF86AudioMute = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--output-volume" "mute-toggle";
        };
        XF86AudioMicMute = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--input-volume" "mute-toggle";
        };

        XF86MonBrightnessUp = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--brightness" "raise";
        };
        XF86MonBrightnessDown = {
          allow-when-locked = true;
          action = spawn "swayosd-client" "--brightness" "lower";
        };

        "Mod+O" = {
          repeat = false;
          action = toggle-overview;
        };

        "Mod+Q" = {
          repeat = false;
          action = close-window;
        };

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down;
        "Mod+Ctrl+Up".action = move-window-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-down;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-up;
        };

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+Tab".action = focus-window-previous;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;
        "Mod+Alt+F".action = toggle-windowed-fullscreen;

        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Mod+W".action = toggle-column-tabbed-display;

        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        "Mod+Escape" = {
          allow-inhibiting = false;
          action = toggle-keyboard-shortcuts-inhibit;
        };

        "Mod+Shift+E".action = quit;
        "Ctrl+Alt+Delete".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
