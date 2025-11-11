{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    ../modules/common

    ../modules/greeters/tuigreet
    ../modules/desktops/niri

    ../modules/users/eallen

    ../modules/battery
    ../modules/bluetooth
    ../modules/desktop-apps
    ../modules/flatpak
    ../modules/fonts
    ../modules/graphics
    ../modules/logitech-g923
    ../modules/openssh
    ../modules/pipewire
    ../modules/printing
    ../modules/secure-boot
    ../modules/stylix
    ../modules/tailscale
    ../modules/wireless
  ];

  networking.hostName = "ea-desktop25";

  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

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

  system.stateVersion = "25.05";
}
