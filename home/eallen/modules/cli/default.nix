{pkgs, ...}: {
  imports = [
    ./bat.nix
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
  };

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    btop
    nix-tree
    tree
    wget

    # Nix formatter + LSP.
    alejandra
    nil
  ];
}
