{...}: {
  programs.alacritty = {
    enable = true;
    theme = "ayu_dark";
    settings = {
      window = {
        padding = {
          x = 4;
          y = 4;
        };
        dynamic_padding = true;
      };
      font = {
        normal.family = "Cascadia Code";
        size = 13;
      };
      mouse.hide_when_typing = true;
    };
  };
}
