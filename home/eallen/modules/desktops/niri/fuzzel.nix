{
  config,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
in {
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel.override {svgBackend = "librsvg";};
    settings = {
      main = {
        terminal = "${lib.getExe pkgs.alacritty} -e '{cmd}'";
        dpi-aware = false;
        font = "monospace:size=12";
        horizontal-pad = 8;
        vertical-pad = 8;
        inner-pad = 8;
        lines = 8;
        minimal-lines = true;
        width = 64;
        match-counter = true;
      };

      border = {
        radius = 0;
      };

      colors = {
        background = colors.base00 + "ff";
        border = colors.base01 + "ff";
        counter = colors.base03 + "ff";
        input = colors.base05 + "ff";
        match = colors.base05 + "ff";
        placeholder = colors.base03 + "ff";
        prompt = colors.base04 + "ff";
        selection = colors.base02 + "ff";
        selection-match = colors.base05 + "ff";
        selection-text = colors.base05 + "ff";
        text = colors.base05 + "ff";
      };
    };
  };
}
