{
  lib,
  self',
  ...
}: {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg draws the desktop background.";
      After = ["graphical-session.target"];
      BindsTo = ["graphical-session.target"];
    };
    Service = {
      ExecStart = lib.getExe self'.packages.swaybg;
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
