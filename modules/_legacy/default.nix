{
  inputs,
  systems,
  ...
}: let
  nixpkgs = inputs.nixpkgs;
  lib = nixpkgs.lib;
  forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
  pkgsFor = lib.genAttrs (import systems) (
    system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
  );
in {
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };

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
