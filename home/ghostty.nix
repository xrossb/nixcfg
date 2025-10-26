{ ... }:

{
  stylix.targets.ghostty.enable = false;
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Cascadia Code";
      font-size = 13;
      theme = "Ayu";
      window-padding-x = 4;
      window-padding-y = 4;
      window-padding-balance = true;
      window-padding-color = "extend";
      window-theme = "ghostty";
      window-height = 50;
      window-width = 100;
      adw-toolbar-style = "flat";
      mouse-hide-while-typing = true;
    };
  };
}
