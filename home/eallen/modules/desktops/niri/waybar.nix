{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors;
  rgb = color: (lib.concatStringsSep ", " [
    (lib.strings.floatToString ((builtins.fromJSON colors."${color}-dec-r") * 255.0))
    (lib.strings.floatToString ((builtins.fromJSON colors."${color}-dec-g") * 255.0))
    (lib.strings.floatToString ((builtins.fromJSON colors."${color}-dec-b") * 255.0))
  ]);
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      height = 30;
      spacing = 16;
      modules-left = [
        "niri/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        "network"
        "bluetooth"
        "battery"
      ];
      clock = {
        format = "{:%a, %d %b · %I:%M %p}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
      };
      tray = {
        spacing = 16;
        reverse-direction = true;
      };
      network = {
        format-ethernet = " {ifname}";
        format-wifi = " {essid}";
        format-linked = " linked";
        format-disconnected = " disconnected";
        format-disabled = "";
      };
      bluetooth = {
        format-disabled = "";
        format-off = "󰂲 off";
        format-on = "󰂯 on";
        format-connected = "󰂯 {device_alias}";
      };
      battery = rec {
        format = "{icon} {capacity}%";
        tooltip-format = "{timeTo}";
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        format-plugged = " {capacity}%";
        format-charging = " {capacity}%";
        format-full = format-plugged;
      };
    };

    style = ''
      * {
        font-family: monospace, "Symbols Nerd Font";
        font-size: 14px;
        font-weight: bold;
      }

      window#waybar {
        background: linear-gradient(to bottom, rgba(${rgb "base00"}, 0.2), transparent);
        color: #${colors.base06};
        text-shadow: 0 0 2px #${colors.base00};
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      .modules-right {
        margin-right: 16px;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #${colors.base0C};
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: inherit;
        text-shadow: inherit;
      }

      #workspaces button.focused, #workspaces button.active {
        background: rgba(${rgb "base0C"}, 0.5);
        box-shadow: inset 0 -3px #${colors.base0C};
      }

      #workspaces button.urgent {
        background: rgba(${rgb "base09"}, 0.5);
        box-shadow: inset 0 -3px #${colors.base09};
      }
    '';
  };
}
