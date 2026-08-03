{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg draws the desktop background.";
      After = ["graphical-session.target"];
      BindsTo = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.swaybg} --mode fill --image ${../../../../../wallpaper/forest.jpg}";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
