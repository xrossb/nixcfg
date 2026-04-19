{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  pi-coding-agent = pkgs.symlinkJoin {
    name = "pi-coding-agent";
    nativeBuildInputs = [pkgs.makeWrapper];
    paths = [pkgs.pi-coding-agent];
    postBuild = ''
      wrapProgram $out/bin/pi \
        --set NPM_CONFIG_PREFIX ${home}/.pi/npm \
        --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.nodejs_latest]}
    '';
  };
in {
  home.packages = [pi-coding-agent];
}
