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
    glyphs = {
      batteryEmpty = "&#xf306;";
      battery1 = "&#xf30d;";
      battery2 = "&#xf30c;";
      battery3 = "&#xf30b;";
      battery4 = "&#xf30a;";
      battery5 = "&#xf309;";
      battery6 = "&#xf308;";
      battery7 = "&#xf307;";
      batteryFull = "&#xf304;";
      plugged = "&#xf102;";
      bolt = "&#xec1c;";

      btOn = "&#xe1a7;";
      btOff = "&#xe1a9;";
      btConnected = "&#xe1a8;";

      lan = "&#xeb2f;";
      wifi1 = "&#xe4ca;";
      wifi2 = "&#xe4d9;";
      wifi3 = "&#xe63e;";
      wifiOff = "&#xe648;";

      speakerOff = "&#xe04f;";
      speakerMute = "&#xe04e;";
      speakerLow = "&#xe04d;";
      speakerHigh = "&#xe050;";

      magnifyingGlass = "&#xe8b6;";

      powerOff = "&#xe8ac;";
    };

    openTerminal = command: "${lib.getExe pkgs.alacritty} -e ${lib.strings.escapeShellArg command}";
    formatIcon = text: "<span size='larger' weight='bold' rise='-4500'>${text}</span>";
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
        format = "${formatIcon "{icon}"}${format-capacity}";
        format-icons = with glyphs; [
          batteryEmpty
          battery1
          battery2
          battery3
          battery4
          battery5
          battery6
          battery7
          batteryFull
        ];
        format-plugged = "${formatIcon glyphs.plugged}${format-capacity}";
        format-charging = "${formatIcon glyphs.bolt}${format-capacity}";
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
        format-disabled = formatIcon glyphs.btOff;
        format-off = format-disabled;
        format-on = formatIcon glyphs.btOn;
        format-connected = formatIcon glyphs.btConnected;
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
        on-click = openTerminal (lib.getExe pkgs.bluetuith);
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
        format-ethernet = formatIcon glyphs.lan;
        format-wifi = formatIcon "{icon}";
        format-linked = formatIcon "{icon}";
        format-disconnected = formatIcon glyphs.wifi3;
        format-disabled = formatIcon glyphs.wifiOff;
        format-icons = with glyphs; [
          wifi1
          wifi2
          wifi3
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
        on-click = openTerminal (lib.getExe' pkgs.networkmanager "nmtui");
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
        format = formatIcon "{icon}";
        format-muted = formatIcon glyphs.speakerOff;
        format-icons = with glyphs; [
          speakerMute
          speakerLow
          speakerHigh
        ];
        tooltip-format = lib.concatStringsSep "\n" [
          "sink: {node_name}"
          "source: {source_desc}"
        ];
        on-click = lib.getExe pkgs.pavucontrol;
      };

      "custom/launcher" = {
        format = formatIcon glyphs.magnifyingGlass;
        tooltip-format = "Open launcher";
        on-click = "fuzzel";
      };

      "custom/power" = {
        format = formatIcon glyphs.powerOff;
        tooltip-format = "Power options";
        menu = "on-click";
        menu-file = ./power-menu.xml;
        menu-actions = {
          hibernate = "systemctl hibernate";
          poweroff = "systemctl poweroff";
          restart = "systemctl reboot";
          signout = lib.getExe pkgs.wayland-logout;
          sleep = "systemctl suspend";
        };
      };
    };

    "style.css".path = ./style.css;
  };
}
