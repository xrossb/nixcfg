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
        normal.family = "CaskaydiaCove Nerd Font Mono";
        size = 13;
      };
      mouse.hide_when_typing = true;
      env.TERM = "xterm-256color"; # "alacritty" isn't recognised by a lot of CLI tools.
    };
  };
}
