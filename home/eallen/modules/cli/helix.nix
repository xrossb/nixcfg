{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "github_dark";
      editor = {
        rulers = [
          80
          100
        ];
        whitespace.render = {
          space = "all";
          tab = "all";
        };
        inline-diagnostics = {
          cursor-line = "info";
          other-lines = "warning";
        };
      };
      keys.normal = {
        space.space = "file_picker";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
      }
    ];
  };
}
