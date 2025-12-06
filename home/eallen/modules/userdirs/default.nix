{pkgs, ...}: {
  home.packages = with pkgs; [xdg-user-dirs xdg-user-dirs-gtk];
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
