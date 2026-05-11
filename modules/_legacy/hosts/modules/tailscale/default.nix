{...}: {
  services.tailscale.enable = true;
  systemd.services.tailscaled.serviceConfig.TimeoutStopSec = 5;
}
