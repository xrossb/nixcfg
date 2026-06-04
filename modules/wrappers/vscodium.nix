{...}: {
  flake.wrappers.vscodium = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.vscodium;
    runtimePkgs = with pkgs; [
      # go
      delve
      impl
      go
      go-tools
      gotools
      gopls
      gotests

      # nix
      alejandra
      nixd

      # rust
      rust-analyzer
      rustfmt
    ];
  };
}
