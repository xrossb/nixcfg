{pkgs, ...}: {
  home.packages = with pkgs; [
    gcr_4 # Required for pinentry.
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
