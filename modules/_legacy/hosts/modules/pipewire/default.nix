{...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.extraConfig = {
      "10-default-volume" = {
        "wireplumber.settings"."device.routes.default-source-volume" = 0.5;
      };
    };
  };
}
