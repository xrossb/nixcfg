{
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = lib.concatStringsSep " " [
          (lib.getExe pkgs.tuigreet)
          "--time"
          "--asterisks"
          # "--user-menu" # TODO: enable when compatible w/ --remember again.
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
