{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.email = "hi@eallen.me";
      user.name = "Edward Allen";

      fetch.prune = true;
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      push.default = "current";
      rerere.enabled = true;

      delta = {
        features = "decorations";
        syntax-theme = "OneHalfDark";
        navigate = true;
        light = false;
        line-numbers = true;
        zero-style = "dim syntax normal";
        plus-style = "syntax normal";
        minus-style = "dim syntax dim auto";
        decorations.hunk-header-decoration-style = "none";
      };
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
