{self', ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = self'.packages.waybar;
  };
}
