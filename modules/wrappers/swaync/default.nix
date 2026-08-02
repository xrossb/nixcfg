{...}: {
  flake.wrappers.swaync = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.swaynotificationcenter;
    flags = {
      "--config" = ./config.json;
      "--style" = ./style.css;
    };
  };
}
