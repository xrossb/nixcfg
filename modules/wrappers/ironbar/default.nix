{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.ironbar = inputs.wrappers.lib.wrapPackage ({...}: let
      config = {
        position = "top";
        height = 30;
        layer = "overlay";
        popup_autohide = true;
        start = [
          {type = "launcher";}
          {type = "workspaces";}
        ];
        center = [
          {
            type = "clock";
            format = "%a, %d %b · %-l:%M %P";
          }
        ];
        end = [
          {type = "tray";}
          {type = "battery";}
          {type = "volume";}
          {type = "bluetooth";}
          {type = "network_manager";}
          {type = "menu";}
        ];
      };
    in {
      inherit pkgs;
      package = pkgs.ironbar;
      env = {
        IRONBAR_CSS = toString ./style.css;
        IRONBAR_CONFIG = builtins.toFile "config.json" (builtins.toJSON config);
      };
    });
  };
}
