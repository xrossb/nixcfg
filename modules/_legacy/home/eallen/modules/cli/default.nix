{
  pkgs,
  self',
  ...
}: {
  imports = [
    ./bat.nix
    ./comma.nix
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

      ns = "sudo nixos-rebuild switch";
      nt = "sudo nixos-rebuild test";
      gc = "sudo nix-collect-garbage -d";
    };
  };

  home.packages = with pkgs; [
    self'.packages.tmux

    bluetuith
    brightnessctl
    btop
    lf
    nix-tree
    ripgrep
    tree
    wget
  ];
}
