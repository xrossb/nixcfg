{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
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
