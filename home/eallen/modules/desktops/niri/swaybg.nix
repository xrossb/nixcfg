{
  config,
  pkgs,
  ...
}: {
  # home.packages = with pkgs; [
  #   swaybg
  # ];

  # home.file."Pictures/Wallpapers" = {
  #   enable = true;
  #   source = ../wallpaper;
  #   recursive = true;
  # };

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg draws the desktop background.";
      After = ["graphical-session.target"];
      BindsTo = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg --image ${config.stylix.image}";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
