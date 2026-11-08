{
  inputs,
  lib,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  tuigreet = inputs.tuigreet.packages.${system}.default;
in {
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = lib.concatStringsSep " " [
          (lib.getExe tuigreet)
          "--time"
          "--asterisks"
          "--user-menu"
          "--user-menu-min-uid=1000"
          "--user-menu-max-uid=29999" # ignore nixbld users.
          "--remember"
          "--prompt-padding=0"
        ];
        user = "greeter";
      };
    };
  };
}
