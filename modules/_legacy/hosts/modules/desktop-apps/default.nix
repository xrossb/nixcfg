{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome-disk-utility
    nautilus

    cider-2

    gamescope

    vscodium
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs:
        with pkgs; [
          autoconf
          automake
          cairo
          cmake
          ffmpeg
          gcc
          gnumake
          icu
          libffi
          libjpeg
          libressl
          libxcrypt
          libxcrypt-legacy
          libxml2
          libxslt
          openssl_3
          pkg-config
          zstd
        ];
    };
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
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
      "inode/*" = ["org.gnome.Nautilus.desktop"];
      "text/*" = ["codium.desktop"];
      "image/*" = ["org.gnome.Loupe.desktop"];
      "audio/*" = ["org.gnome.Decibels.desktop"];
      "video/*" = ["org.gnome.Showtime.desktop"];
      "application/pdf" = ["org.gnome.Papers.desktop"];
      "application/x-bzpdf" = ["org.gnome.Papers.desktop"];
      "application/x-ext-pdf" = ["org.gnome.Papers.desktop"];
      "application/x-gzpdf" = ["org.gnome.Papers.desktop"];
      "application/x-xzpdf" = ["org.gnome.Papers.desktop"];
      "application/illustrator" = ["org.gnome.Papers.desktop"];
      "compressed/*" = ["org.gnome.FileRoller.desktop"];
      "application/zip" = ["org.gnome.FileRoller.desktop"];
    };
  };
}
