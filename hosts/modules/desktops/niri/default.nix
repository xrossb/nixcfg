{...}: {
  programs.niri.enable = true;

  security.pam.services.hyprlock = {};
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
}
