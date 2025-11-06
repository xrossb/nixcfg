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
    user.signingkey = "998860F9FAF62249";
    commit.gpgsign = true;
    tag.gpgSign = true;
  };
}
