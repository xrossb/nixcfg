{...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        self'.formatter
        nixd
      ];
    };
  };
}
