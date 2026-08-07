{withSystem, ...}: {
  # This module overlays packages defined in this flake over nixpkgs.
  flake.nixosModules.wrappers = {...}: {
    nixpkgs.overlays = [
      (
        final: prev:
          withSystem prev.stdenv.hostPlatform.system (
            {config, ...}: config.packages
          )
      )
    ];
  };
}
