{lib, ...}: {
  flake.wrappers.waybar = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.wrapperModules.waybar];

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

      clock = {
        format = "{:%a, %d %b · %I:%M %p}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar.format.today = "<span color='#000' background='#fff'>{}</span>";
      };

      tray = {
        reverse-direction = true;
      };

      "custom/launcher" = {
        format = "launch";
        on-click = "fuzzel";
      };

      "custom/power" = {
        format = "power";
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
