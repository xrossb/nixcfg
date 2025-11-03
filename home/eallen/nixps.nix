{config, ...}: {
  imports = [
    ./modules/desktops/niri

    ./modules/alacritty
    ./modules/cli
    ./modules/cliphist
    ./modules/stylix
  ];

  home.username = "eallen";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.05";

  # Enable commit signing with the on-device GPG key.
  programs.git.settings = {
    user.signingkey = "BA8B9B76E2A40F49";
    commit.gpgsign = true;
    tag.gpgSign = true;
  };
}
