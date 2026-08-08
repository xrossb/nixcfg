{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.swaync = {
    Unit = {
      Description = "swaync provides a notification daemon + UI.";
      After = ["graphical-session.target"];
      BindsTo = ["graphical-session.target"];
    };
    Service = {
      ExecStart = lib.getExe pkgs.swaynotificationcenter;
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
