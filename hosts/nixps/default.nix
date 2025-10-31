{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-13-9350
    ./hardware-configuration.nix

    ../modules/common

    ../modules/greeters/tuigreet
    ../modules/desktops/niri

    ../modules/users/eallen

    ../modules/bluetooth
    ../modules/desktop-apps
    ../modules/flatpak
    ../modules/fonts
    ../modules/graphics
    ../modules/openssh
    ../modules/pipewire
    ../modules/printing
    ../modules/secure-boot
    ../modules/stylix
    ../modules/wireless
  ];

  networking.hostName = "nixps";

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

  # Workaround for black Steam UI w/ xwayland-satellite + GPU accel enabled on Intel GPUs.
  programs.steam.package = pkgs.steam.override {
    extraArgs = "-system-composer";
  };
}
