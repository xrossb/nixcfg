{lib, ...}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$cmd_duration"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$line_break"
        "$character"
      ];
      add_newline = false;

      character = {
        success_symbol = "\\$";
        error_symbol = "[\\$](red)";
      };

      cmd_duration = {
        min_time = 1000;
        format = "[\\(took $duration\\)]($style)\n";
        style = "dimmed";
      };

      directory = {
        format = "[$path]($style) ";
        style = "blue";
      };

      git_branch = {
        format = "[$branch(:$remote_branch)]($style) ";
        style = "yellow";
      };

      git_commit = {
        format = "[\\(($tag; )$hash\\)]($style) ";
        style = "yellow";
        tag_symbol = "";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        conflicted = "!$count ";
        ahead = "↑$count ";
        behind = "↓$count ";
        diverged = "↑$ahead_count↓$behind_count ";
        untracked = "?$count ";
        stashed = "";
        modified = "~$count ";
        staged = "+$count ";
        renamed = "";
        deleted = "×$count ";
        style = "yellow";
      };

      hostname = {
        ssh_symbol = "@";
        format = "[$ssh_symbol$hostname]($style) ";
        style = "green";
      };

      username = {
        style_root = "red";
        style_user = "green";
        format = "[$user]($style)";
      };

      nix_shell = {
        format = "[*$state (\\($name\\))]($style)";
        style = "bright-blue";
      };
    };
  };
}
