{...}: {
  flake.wrappers.swaybg = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.swaybg;
    flags = {
      "--mode" = "fill";
      "--image" = ./forest.jpg;
    };
  };
}
