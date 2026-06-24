{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["eallen"];
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libGL
      libGLU
      libmpg123
      libsecret
      libvorbis
      SDL2
    ];
  };
}
