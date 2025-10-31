{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-icon-theme

    baobab
    decibels
    deluge
    discord
    gearlever
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-disk-utility
    gnome-font-viewer
    gnome-weather
    loupe
    nautilus
    papers
    showtime
    snapshot
    vscode
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.dconf.enable = true;
  services.gvfs.enable = true;

  programs.firefox = {
    enable = true;
    policies = {
      "SearchEngines" = {
        "Default" = "DuckDuckGo";
      };
      "Homepage" = {
        "StartPage" = "previous-session";
      };
    };
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "text/*" = ["code.desktop"];
      "image/*" = ["org.gnome.Loupe.desktop"];
      "audio/*" = ["org.gnome.Decibels.desktop"];
      "video/*" = ["org.gnome.Showtime.desktop"];
      "application/pdf" = ["org.gnome.Papers.desktop"];
      "application/x-bzpdf" = ["org.gnome.Papers.desktop"];
      "application/x-ext-pdf" = ["org.gnome.Papers.desktop"];
      "application/x-gzpdf" = ["org.gnome.Papers.desktop"];
      "application/x-xzpdf" = ["org.gnome.Papers.desktop"];
      "application/illustrator" = ["org.gnome.Papers.desktop"];
    };
  };
}
