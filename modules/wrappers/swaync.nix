{...}: {
  flake.wrappers.swaync = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.swaynotificationcenter;
  };
}
