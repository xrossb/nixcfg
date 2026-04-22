{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    update.auto.enable = true;
    packages = [
      "io.github.kolunmi.Bazaar"

      "org.gnome.baobab"
      "org.gnome.Calculator"
      "org.gnome.Characters"
      "org.gnome.Decibels"
      "org.gnome.FileRoller"
      "org.gnome.font-viewer"
      "org.gnome.Loupe"
      "org.gnome.Papers"
      "org.gnome.Showtime"

      "com.discordapp.Discord"
    ];
    overrides = {
      # Fix un-themed cursor in some Wayland apps.
      global.Context.filesystems = "/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro";
    };
  };

  xdg.portal.enable = true;
}
