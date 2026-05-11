{...}: {
  programs.alacritty = {
    enable = true;
    theme = "ayu_dark";

    settings = {
      terminal.shell = "tmux";
      env.TERM = "xterm-256color"; # "alacritty" isn't recognised by a lot of CLI tools.

      font = {
        normal.family = "CaskaydiaCove Nerd Font Mono";
        size = 13;
      };

      window = {
        padding = {
          x = 4;
          y = 4;
        };
        dynamic_padding = true;
      };

      mouse.hide_when_typing = true;
    };
  };
}
