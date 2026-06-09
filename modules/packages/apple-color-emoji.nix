{...}: {
  perSystem = {pkgs, ...}: {
    packages.apple-color-emoji = pkgs.stdenvNoCC.mkDerivation {
      pname = "apple-color-emoji";
      version = "2026.02.19";

      src = pkgs.fetchurl {
        url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260219-2aa12422/AppleColorEmoji-Linux.ttf";
        hash = "sha256-U1oEOvBHBtJEcQWeZHRb/IDWYXraLuo0NdxWINwPUxg=";
      };
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
      '';
    };
  };
}
