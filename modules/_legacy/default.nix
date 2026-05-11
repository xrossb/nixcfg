{inputs, ...}: let
  lib = inputs.nixpkgs.lib;
in {
  flake.nixosConfigurations = {
    nixps = lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [./hosts/nixps];
    };

    ea-desktop25 = lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [./hosts/ea-desktop25];
    };

    ea-pocket = lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [./hosts/ea-pocket];
    };
  };
}
