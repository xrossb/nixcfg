{config, ...}: {
  imports = [
    ./modules/desktops/niri

    ./modules/alacritty
    ./modules/cli
    ./modules/stylix
  ];

  home.username = "eallen";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.05";
}
