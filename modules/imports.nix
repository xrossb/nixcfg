{inputs, ...}: {
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  perSystem = {system, ...}: {
    wrappers.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
