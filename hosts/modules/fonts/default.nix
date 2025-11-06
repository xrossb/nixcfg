{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      cascadia-code
      dejavu_fonts
      fira-code
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
      ubuntu-sans
      ubuntu-sans-mono

      nerd-fonts.symbols-only
      nerd-fonts.adwaita-mono
    ];
  };
}
