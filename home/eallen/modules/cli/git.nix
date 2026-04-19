{
  lib,
  pkgs,
  ...
}: let
  fzf = lib.getExe pkgs.fzf;
  delta = lib.getExe pkgs.delta;
in {
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

      alias = {
        cleanout = "!git clean -df && git restore .";
        default = "!git remote show origin | sed -n '/HEAD branch/s/.*: //p'";
        grab = ''
          !git branch -r --sort=committerdate --format='%(refname:lstrip=2)' \
            | ${fzf} --preview='git diff HEAD...{1} | ${delta}' --preview-window='right:70%' \
            | sed 's/origin\\///' \
            | xargs git switch
        '';
        recent = ''

        '';
        unwip = "!git log -n 1 | grep -q -c wip && git reset HEAD~1";
        wip = ''
          !git add --all; \
          git ls-files --deleted -z | xargs -r -0 git rm; \
          git commit --message=wip
        '';
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
