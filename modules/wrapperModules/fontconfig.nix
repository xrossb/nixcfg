{lib, ...}: {
  flake.modules.fontconfig = {
    config,
    pkgs,
    ...
  }: {
    options.fontPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };

    config = lib.mkIf (config.fontPackages != []) {
      env.FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = config.fontPackages;
      };
    };
  };
}
