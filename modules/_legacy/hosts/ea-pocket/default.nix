# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.chuwi-minibook-x
    ./hardware.nix

    ../modules/common

    ../modules/greeters/tuigreet
    ../modules/desktops/niri

    ../modules/users/eallen

    ../modules/battery
    ../modules/bluetooth
    ../modules/desktop-apps
    ../modules/fonts
    ../modules/graphics
    ../modules/openssh
    ../modules/pipewire
    ../modules/printing
    ../modules/stylix
    ../modules/tailscale
    ../modules/wireless
  ];

  services.thermald.enable = true;
  services.tlp.enable = true;
  hardware.sensor.iio.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ea-pocket"; # Define your hostname.

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  console.packages = with pkgs; [terminus_font];
  console.font = "ter-v32n";

  # make the enter key register as enter instead of kp_enter (wtf!)
  services.udev.extraHwdb = ''
    evdev:name:AT Translated Set 2 keyboard:*
      KEYBOARD_KEY_9c=enter
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
