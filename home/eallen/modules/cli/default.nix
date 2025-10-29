{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
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
    htop
    nix-tree
    tree
    wget

    # Nix formatter + LSP.
    alejandra
    nil
  ];
}
