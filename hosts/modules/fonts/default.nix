{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      cascadia-code
      dejavu_fonts
      fira-code
      liberation_ttf
      noto-fonts
      noto-fonts-emoji

      nerd-fonts.symbols-only
    ];
  };
}
