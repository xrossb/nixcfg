{...}: {
  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };
  programs.bash.shellAliases.cat = "bat --no-pager --decorations=never";
}
