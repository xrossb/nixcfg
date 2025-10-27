{...}: {
  imports = [
    ./fuzzel.nix
    ./ghostty.nix
    ./mako.nix
    ./niri.nix
    ./polkit.nix
    ./shell.nix
    ./swaybg.nix
    ./swaylock.nix
    ./swayosd.nix
    ./waybar.nix
  ];

  home.username = "eallen";
  home.homeDirectory = "/home/eallen";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
