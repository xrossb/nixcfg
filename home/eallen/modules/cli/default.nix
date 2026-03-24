{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "ls --color --group-directories-first -vAF";
      ll = "ls -l";
      gcm = "git commit -m";
      gd = "git diff";
      gds = "git diff --staged";
      gs = "git status";
      gsw = "git switch";
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    terminal = "tmux-256color";
    focusEvents = true;
    aggressiveResize = true;
    escapeTime = 0;
    historyLimit = 10000;
    extraConfig = ''
      set -g monitor-activity on

      set -g set-titles on
      set -g set-titles-string '#{session_name} · #{b:pane_current_path} · #{?#{==:#{pane_title},#{host}},#{window_name},#{pane_title}}'

      # theme
      set -g pane-border-style fg=colour238
      set -g pane-active-border-style fg=colour166
      set -g status-style bg=colour235,fg=colour136,default
      set -g window-status-style fg=colour244,bg=default,dim
      set -g window-status-current-style fg=colour166,bg=default,bright
      set -g window-status-activity-style fg=colour244,bg=default,underscore
      set -g status-justify absolute-centre
      set -g status-right ""

      # stay in copy mode
      unbind -T copy-mode-vi MouseDragEnd1Pane
      unbind -T copy-mode MouseDragEnd1Pane

      # prefix + quick swap
      unbind C-b
      set -g prefix C-a
      bind C-a last-window
      bind a send-prefix

      # reverse splits
      bind h split-window -v
      bind v split-window -h

      # quick reload
      bind r source-file ~/.config/tmux/tmux.conf

      # pick windows
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # alt key pane navigation
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      # swap panes
      bind Left swap-pane -s '{left-of}'
      bind Right swap-pane -s '{right-of}'
      bind Up swap-pane -s '{up-of}'
      bind Down swap-pane -s '{down-of}'
      bind C-h swap-pane -s '{left-of}'
      bind C-l swap-pane -s '{right-of}'
      bind C-k swap-pane -s '{up-of}'
      bind C-j swap-pane -s '{down-of}'

      # resize panes
      bind -n M-S-Left resize-pane -L 2
      bind -n M-S-Right resize-pane -R 2
      bind -n M-S-Up resize-pane -U 2
      bind -n M-S-Down resize-pane -D 2
      bind -n M-H resize-pane -L 2
      bind -n M-L resize-pane -R 2
      bind -n M-K resize-pane -U 2
      bind -n M-J resize-pane -D 2
    '';
  };

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    btop
    nix-tree
    ripgrep
    tree
    wget

    # Nix formatter + LSP.
    alejandra
    nil
  ];
}
