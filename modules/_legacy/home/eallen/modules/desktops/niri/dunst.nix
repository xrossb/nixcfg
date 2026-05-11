{lib, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "(8, 8)";
        font = lib.mkForce "monospace 11";
        frame_width = 2;
        gap_size = 4;
        vertical_alignment = "top";
        min_icon_size = 32;
        max_icon_size = 32;
        idle_threshold = 60;
      };

      urgency_low = {
        idle_threshold = 0;
        fullscreen = "pushback";
      };

      urgency_normal = {
        timeout = 12;
      };
    };
  };
}
