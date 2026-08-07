{
  inputs,
  withSystem,
  self,
  ...
}: let
  lib = inputs.nixpkgs.lib;
  nixosSystem = system: config:
    withSystem system (
      {self', ...}:
        lib.nixosSystem (
          lib.recursiveUpdate
          {
            inherit system;
            specialArgs = {
              inherit inputs self';
            };
          }
          config
        )
    );
in {
  flake.nixosConfigurations = {
    nixps = nixosSystem "x86_64-linux" {
      modules = [
        self.nixosModules.wrappers
        ./hosts/nixps
      ];
    };

    ea-desktop25 = nixosSystem "x86_64-linux" {
      modules = [
        self.nixosModules.wrappers
        ./hosts/ea-desktop25
      ];
    };

    ea-pocket = nixosSystem "x86_64-linux" {
      modules = [
        self.nixosModules.wrappers
        ./hosts/ea-pocket
      ];
    };
  };
}
