{
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.concatStringsSep " " [
          (lib.getExe pkgs.tuigreet)
          "--time"
          "--asterisks"
          "--user-menu"
          "--remember"
          "--prompt-padding 0"
        ];
        user = "greeter";
      };
    };
  };
}
