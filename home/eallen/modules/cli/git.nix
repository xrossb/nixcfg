{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.email = "hi@eallen.me";
      user.name = "Edward Allen";
    };
  };
}
