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
    };
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
