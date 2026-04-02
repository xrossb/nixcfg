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
    extraConfig = ''
      # use ctrl+a as prefix
      unbind C-b
      set -g prefix C-a
      bind C-a last-window
      bind a send-prefix

      set -g status-keys vi
      set -g mode-keys vi
      set -g renumber-windows on

      # let me scrolllllll
      set -g mouse on

      set -g escape-time 0
      set -g base-index 1
      set -g aggressive-resize on
      set -g monitor-activity on

      # stay in copy mode after drag
      unbind -T copy-mode-vi MouseDragEnd1Pane
      unbind -T copy-mode MouseDragEnd1Pane

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

      # create windows at current path
      bind c new-window -c "#{pane_current_path}"

      # reverse splits
      bind h split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"

      # quick reload
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "config reloaded"

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
      bind -n M-Left if -F '#{pane_at_left}' ''' 'select-pane -L'
      bind -n M-Right if -F '#{pane_at_right}' ''' 'select-pane -R'
      bind -n M-Up if -F '#{pane_at_top}' ''' 'select-pane -U'
      bind -n M-Down if -F '#{pane_at_bottom}' ''' 'select-pane -D'
      bind -n M-h if -F '#{pane_at_left}' ''' 'select-pane -L'
      bind -n M-l if -F '#{pane_at_right}' ''' 'select-pane -R'
      bind -n M-k if -F '#{pane_at_top}' ''' 'select-pane -U'
      bind -n M-j if -F '#{pane_at_bottom}' ''' 'select-pane -D'

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

      # kill without asking
      bind x kill-pane
      bind & kill-window
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
