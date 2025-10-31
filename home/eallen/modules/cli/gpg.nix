{pkgs, ...}: {
  home.packages = with pkgs; [
    gcr # Required for pinentry.
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
