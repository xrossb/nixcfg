{pkgs, ...}: {
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    adwaita-fonts
    fira-code
    cascadia-code
    nerd-fonts.symbols-only
  ];
}
