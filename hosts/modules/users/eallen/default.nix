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
  };

  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  home-manager.users.eallen = import ../../../../home/eallen/${config.networking.hostName}.nix;

  security.sudo.wheelNeedsPassword = false;
}
