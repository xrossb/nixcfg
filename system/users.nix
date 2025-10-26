{ ... }:

{
  users.users.eallen = {
    isNormalUser = true;
    description = "Eddie";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
