{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./flatpak.nix
    ./fonts.nix
    ./hardware.nix
    ./nautilus.nix
    ./niri.nix
    ./stylix.nix
    ./users.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    git
    helix
    htop
    loupe
    nil
    nixfmt-rfc-style
    vscode
    wget
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/*" = [ "code.desktop" ];
      "image/*" = [ "org.gnome.Loupe.desktop" ];
    };
  };

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
}
