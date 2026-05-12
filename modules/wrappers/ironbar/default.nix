{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.ironbar = inputs.wrappers.lib.wrapPackage ({...}: let
      config = {
        position = "top";
        height = 30;
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
      flags = {
        "--theme" = "custom"; # required to pick up style.css?
      };
      env = {
        IRONBAR_CSS = ./style.css;
        IRONBAR_CONFIG = builtins.toFile "config.json" (builtins.toJSON config);
      };
    });
  };
}
