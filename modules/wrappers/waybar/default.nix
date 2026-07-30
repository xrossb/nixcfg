{
  lib,
  self,
  ...
}: {
  flake.wrappers.waybar = {
    pkgs,
    wlib,
    ...
  }: let
    run-sh = command: "${lib.getExe pkgs.alacritty} -e ${lib.strings.escapeShellArg command}";
    icon = glyph: "<span size='larger' weight='bold' rise='-4500'>&#x${glyph};</span>";
  in {
    imports = [
      wlib.wrapperModules.waybar
      self.modules.fontconfig
    ];

    fontPackages = with pkgs; [
      jetbrains-mono
      material-symbols
    ];

    settings = {
      height = 30;
      layer = "top";
      position = "top";
      modules-left = [
        "custom/launcher"
        "niri/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "privacy"
        "tray"
        "battery"
        "wireplumber"
        "bluetooth"
        "network"
        "custom/power"
      ];

      battery = let
        format-capacity = "<b><small><span size='5500'> </span>{capacity}%</small></b>";
      in rec {
        format = "${icon "{icon}"}${format-capacity}";
        format-icons = [
          "f306"
          "f30d"
          "f30c"
          "f30b"
          "f30a"
          "f309"
          "f308"
          "f307"
          "f304"
        ];
        format-plugged = "${icon "f102"}${format-capacity}";
        format-charging = "${icon "ec1c"}${format-capacity}";
        format-full = format-plugged;
        format-time = "{H}h {M}m";
        tooltip-format =
          "<tt>"
          + lib.concatStringsSep "\n" [
            "draw: {power:.2f}W"
            "health: {health}%"
            ""
            "{timeTo}"
          ]
          + "</tt>";
      };

      bluetooth = rec {
        format-disabled = icon "e1a9";
        format-off = format-disabled;
        format-on = icon "e1a7";
        format-connected = icon "e1a8";
        tooltip-format =
          "<tt>"
          + lib.concatStringsSep "\n" [
            "name: {controller_alias}"
            "addr: {controller_address}"
          ]
          + "</tt>";
        tooltip-format-connected =
          "<tt>"
          + lib.concatStringsSep "\n" [
            tooltip-format
            ""
            "{device_enumerate}"
          ]
          + "</tt>";
        tooltip-format-enumerate-connected = "{device_alias} {device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias} {device_address} ({device_battery_percentage}%)";
        on-click = run-sh (lib.getExe pkgs.bluetuith);
      };

      clock = {
        format = "<b>{:%a, %d %b · %I:%M %p}</b>";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar.format.today = "<span color='#000' background='#fff'>{}</span>";
      };

      network = let
        format-ethernet = lib.concatStringsSep "\n" [
          "if: {ifname}"
          "ip: {ipaddr}"
          "gw: {gwaddr}"
          "mask: {netmask} ({cidr})"
        ];
        format-bandwidth = "up: {bandwidthUpBits}, down: {bandwidthDownBits}";
      in {
        format-ethernet = icon "eb2f";
        format-wifi = icon "{icon}";
        format-linked = icon "{icon}";
        format-disconnected = icon "e63e";
        format-disabled = icon "e648";
        format-icons = [
          "e4ca"
          "e4d9"
          "e63e"
        ];
        tooltip-format-ethernet =
          "<tt>"
          + lib.concatStringsSep "\n" [
            format-ethernet
            ""
            format-bandwidth
          ]
          + "</tt>";
        tooltip-format-wifi =
          "<tt>"
          + lib.concatStringsSep "\n" [
            format-ethernet
            ""
            "ssid: {essid}"
            "freq: {frequency}GHz"
            "str: {signalStrength}% ({signaldBm}dBm)"
            ""
            format-bandwidth
          ]
          + "</tt>";
        on-click = run-sh (lib.getExe' pkgs.networkmanager "nmtui");
      };

      "niri/workspaces" = {
        format = "<b>{icon}</b>";
        format-icons = {
          active = "■";
        };
      };

      tray = {
        reverse-direction = true;
      };

      wireplumber = {
        format = icon "{icon}";
        format-muted = icon "e04f";
        format-icons = [
          "e04e"
          "e04d"
          "e050"
        ];
        tooltip-format = lib.concatStringsSep "\n" [
          "sink: {node_name}"
          "source: {source_desc}"
        ];
        on-click = lib.getExe pkgs.pavucontrol;
      };

      "custom/launcher" = {
        format = icon "e8b6";
        tooltip-format = "Open launcher";
        on-click = "fuzzel";
      };

      "custom/power" = {
        format = icon "e8ac";
        tooltip-format = "Power options";
        menu = "on-click";
        menu-file = ./power-menu.xml;
        menu-actions = {
          hibernate = "systemctl hibernate";
          poweroff = "systemctl poweroff";
          reboot = "systemctl reboot";
          signout = lib.getExe pkgs.wayland-logout;
          sleep = "systemctl suspend";
        };
      };
    };

    "style.css".path = ./style.css;
  };
}
