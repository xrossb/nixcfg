{self', ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = self'.packages.helix;
  };
}
