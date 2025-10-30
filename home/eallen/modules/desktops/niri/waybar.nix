{
  config,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  run-sh = command: "${lib.getExe pkgs.alacritty} -e ${lib.strings.escapeShellArg command}";
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
        "mpris"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        "network"
        "bluetooth"
        "wireplumber"
        "battery"
      ];
      clock = {
        format = "{:%a, %d %b · %I:%M %p}";
        "tooltip-format" = "<tt>{calendar}</tt>";
      };
      tray = {
        spacing = 16;
        reverse-direction = true;
      };
      mpris = {
        "format" = " {artist} - {title}";
        "artist-len" = 16;
        "title-len" = 24;
        "tooltip-format" = lib.concatStringsSep "\n" [
          "{player} ({status})"
          ""
          "{title}"
          "{album} - {artist}"
          ""
          "{position} / {length}"
        ];
      };
      network = rec {
        max-length = 30;
        format-ethernet = " {ifname}";
        format-wifi = " {essid}";
        format-linked = " linked";
        format-disconnected = " disconnected";
        format-disabled = "";
        tooltip-format-ethernet = lib.concatStringsSep "\n" [
          "if: {ifname}"
          "ip: {ipaddr}"
          "gw: {gwaddr}"
          "mask: {netmask} ({cidr})"
          ""
          "down: {bandwidthDownBits}, up: {bandwidthUpBits}"
        ];
        tooltip-format-wifi =
          tooltip-format-ethernet
          + "\n"
          + lib.concatStringsSep "\n" [
            ""
            "ssid: {essid}"
            "freq: {frequency}GHz"
            "str: {signalStrength}% ({signaldBm}dBm)"
          ];
        on-click = run-sh (lib.getExe' pkgs.networkmanager "nmtui");
      };
      bluetooth = rec {
        format-disabled = "";
        format-off = "";
        format-on = " on";
        format-connected = " {num_connections} connected";
        tooltip-format = lib.concatStringsSep "\n" [
          "name: {controller_alias}"
          "addr: {controller_address}"
        ];
        tooltip-format-connected =
          tooltip-format
          + "\n"
          + lib.concatStringsSep "\n" [
            ""
            "{device_enumerate}"
          ];
        tooltip-format-enumerate-connected = "{device_alias} {device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias} {device_address} ({device_battery_percentage}%)";
        on-click = run-sh (lib.getExe pkgs.bluetuith);
      };
      wireplumber = {
        format = " {volume}%";
        format-muted = " {volume}%";
        format-icons = ["" "" ""];
        tooltip-format = lib.concatStringsSep "\n" [
          "sink: {node_name}"
          "source: {source_desc}"
        ];
        on-click = lib.getExe pkgs.pavucontrol;
      };
      battery = rec {
        format = "{icon} {capacity}%";
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
        format-time = "{H}h {M}m";
        tooltip-format = lib.concatStringsSep "\n" [
          "draw: {power:.2f}W"
          "health: {health}%"
          ""
          "{timeTo}"
        ];
      };
    };

    style = ''
      * {
        font-family: monospace, "Symbols Nerd Font";
        font-size: 14px;
        font-weight: bold;
      }

      window#waybar {
        background: linear-gradient(to bottom, alpha(#${colors.base00}, 0.2), transparent);
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
        background: alpha(#${colors.base0C}, 0.5);
        box-shadow: inset 0 -3px #${colors.base0C};
      }

      #workspaces button.urgent {
        background: alpha(#${colors.base09}, 0.5);
        box-shadow: inset 0 -3px #${colors.base09};
      }
    '';
  };
}
