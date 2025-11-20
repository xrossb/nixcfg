{
  inputs,
  pkgs,
  ...
}: let
  shell-yeah = inputs.shell-yeah.packages.${pkgs.system}.default;
in {
  systemd.user.services.shell-yeah = {
    Unit = {
      Description = "shell-yeah is a custom desktop environment.";
      After = ["graphical-session.target"];
      BindsTo = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${shell-yeah}/bin/shell-yeah";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
