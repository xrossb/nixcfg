{config, ...}: {
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
    user.signingkey = "BA26503097EA0D9C";
    commit.gpgsign = true;
    tag.gpgSign = true;
  };

  programs.niri.settings.outputs.DSI-1.scale = 1.75;
}
