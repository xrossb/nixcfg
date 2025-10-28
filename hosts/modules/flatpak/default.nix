{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "io.github.kolunmi.Bazaar"
    ];
    overrides = {
      # Fix un-themed cursor in some Wayland apps.
      global.Context.filesystems = "/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro";
    };
  };

  xdg.portal.enable = true;
}
