{...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "io.github.kolunmi.Bazaar"
    ];
  };
}
