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
      "docker"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfBa877oVVuHnwNeplgb5NQaenXujRGTNXPuAnXokNu eallen@nixps"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDnThESB2x4fsCpVTDjREnXlhIuFylzbisvwEn0WGc1i eallen@ea-mbp21"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIA7Oq6wBatGvvQDB84Zx9+Qdyke0JIgjHshmXI7a2u eallen@ea-desktop25/nix"
    ];
  };

  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  home-manager.users.eallen = import ../../../../home/eallen/${config.networking.hostName}.nix;

  security.sudo.wheelNeedsPassword = false;
}
