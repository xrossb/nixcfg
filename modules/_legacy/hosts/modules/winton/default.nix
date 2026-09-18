{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  winton = inputs.winton.packages.${system}.default;
in {
  environment.systemPackages = [winton];
}
