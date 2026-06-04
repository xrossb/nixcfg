{...}: {
  flake.wrappers.vscodium = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.vscodium;
    runtimePkgs = with pkgs; [
      alejandra
      nixd
    ];
  };
}
