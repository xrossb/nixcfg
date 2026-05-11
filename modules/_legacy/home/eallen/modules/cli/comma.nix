{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.default
  ];

  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;
}
