{self', ...}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    package = self'.packages.starship;
  };
}
