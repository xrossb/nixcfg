{config, ...}: let
  colors = config.lib.stylix.colors;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        animation = ["fade, 1, 2, default"];
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "512, 64";
          outline_thickness = 1;
          rounding = 8;
          font_color = "rgb(${colors.base05})";
          inner_color = "rgb(${colors.base00})";
          outer_color = "rgb(${colors.base01})";
          fail_color = "rgb(${colors.base08})";
          font_family = "monospace";
          placeholder_text = "<span color=\"##${colors.base03}\">password</span>";
          fade_on_empty = false;
        }
      ];

      label = [
        {
          text = "$TIME12";
          font_family = "monospace Bold";
          font_size = 16;
          color = "rgb(${colors.base04})";
          position = "0, -16";
          valign = "top";
        }
        {
          text = "cmd[] echo $USER @ $HOSTNAME";
          font_family = "monospace Bold";
          font_size = 16;
          color = "rgb(${colors.base04})";
          position = "0, 16";
          valign = "bottom";
        }
      ];
    };
  };
}
