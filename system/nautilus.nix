{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    adwaita-icon-theme
    gnome-icon-theme
  ];
  programs.dconf.enable = true;
  services.gvfs.enable = true;
}
