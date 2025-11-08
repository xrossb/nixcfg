{pkgs, ...}: {
  environment.systemPackages = with pkgs; [oversteer];

  services.udev.packages = with pkgs; [oversteer];
  services.udev.extraRules = ''
    ATTR{idVendor}=="046d", ATTR{idProduct}=="c26d", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 046d -p c26d -M 0f00010142 -C 0x03 -m 01 -r 01"
  '';
}
