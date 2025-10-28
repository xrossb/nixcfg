{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "io.github.kolunmi.Bazaar"
    ];
  };

  xdg.portal.enable = true;
}
