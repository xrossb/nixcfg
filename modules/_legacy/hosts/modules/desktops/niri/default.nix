{pkgs, ...}: {
  programs.niri.enable = true;

  security.pam.services.hyprlock = {};
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  # Workaround for black Steam UI w/ xwayland-satellite.
  programs.steam.package = pkgs.steam.override {
    extraArgs = "-system-composer";
  };
}
