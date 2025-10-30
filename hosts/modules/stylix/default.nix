{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = ../../../wallpaper/glow.png;

    cursor = {
      name = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };

    fonts = {
      serif = {
        name = "Liberation Serif";
        package = pkgs.liberation_ttf;
      };
      sansSerif = {
        name = "Adwaita Sans";
        package = pkgs.adwaita-fonts;
      };
      monospace = {
        name = "Adwaita Mono";
        package = pkgs.adwaita-fonts;
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
