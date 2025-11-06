{
  config,
  lib,
  ...
}: {
  imports = [
    ./modules/desktops/niri

    ./modules/alacritty
    ./modules/cli
    ./modules/cliphist
    ./modules/stylix
    ./modules/userdirs
  ];

  home.username = "eallen";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.05";

  # Enable commit signing with the on-device GPG key.
  programs.git.settings = {
    user.signingkey = "998860F9FAF62249";
    commit.gpgsign = true;
    tag.gpgSign = true;
  };

  # Override default Niri column sizes for very wide displays.
  # TODO: Move these settings to an output block in the default Niri config, when
  # supported by niri-flake.
  programs.niri.settings.layout = {
    default-column-width.proportion = lib.mkForce 0.33333;
    preset-column-widths = lib.mkForce [
      {proportion = 0.25;}
      {proportion = 0.33333;}
      {proportion = 0.5;}
      {proportion = 0.66667;}
    ];
  };
}
