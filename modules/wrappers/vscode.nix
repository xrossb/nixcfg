{...}: {
  flake.wrappers.vscode = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.vscode-fhs;
    runtimePkgs = with pkgs; [
      # c
      clang-tools

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

      # toml
      taplo
      tombi
    ];
  };
}
