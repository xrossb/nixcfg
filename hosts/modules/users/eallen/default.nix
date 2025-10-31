{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.eallen = {
    isNormalUser = true;
    description = "Eddie";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAg8nxjYNv737Sa4zphqQarbh3P/NYmClWB7fXsdqM0L" # ea-desktop23/win11.wsl
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDcWExEvhiw7Zzf+Vmpe4hAqBYsRh/HUHXKAqNrEoA0" # ea-desktop23/fedora
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfBa877oVVuHnwNeplgb5NQaenXujRGTNXPuAnXokNu eallen@nixps"
    ];
  };

  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  home-manager.users.eallen = import ../../../../home/eallen/${config.networking.hostName}.nix;

  security.sudo.wheelNeedsPassword = false;
}
