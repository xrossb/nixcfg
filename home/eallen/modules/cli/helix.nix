{
  lib,
  pkgs,
  ...
}: let
  nil = lib.getExe pkgs.nil;
  nixd = lib.getExe pkgs.nixd;
  alejandra = lib.getExe pkgs.alejandra;

  typescript-language-server = lib.getExe pkgs.typescript-language-server;
  eslint = "${pkgs.eslint}/bin/eslint";
  prettier = lib.getExe pkgs.prettier;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      vscode-langservers-extracted
      rust-analyzer
      rustfmt
    ];
    settings = {
      theme = "github_dark";
      editor = {
        line-number = "relative";
        cursor-shape.insert = "bar";
        rulers = [
          80
          100
        ];
        whitespace.render = {
          space = "all";
          tab = "all";
        };
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "warning";
        };
        soft-wrap.enable = true;
      };
      keys.normal = {
        space.space = "file_picker";
      };
      keys.insert = {
        "C-space" = "completion";
      };
    };
    languages = {
      language-server = {
        nil.command = nil;
        nixd.command = nixd;

        typescript-language-server = {
          command = typescript-language-server;
          config.preferences.importModuleSpecifierPreference = "non-relative";
        };
        eslint = {
          command = eslint;
          args = ["--stdin"];
        };
      };

      language = [
        {
          name = "nix";
          language-servers = ["nil" "nixd"];
          formatter.command = alejandra;
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = ["typescript-language-server" "eslint"];
          formatter = {
            command = prettier;
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = ["typescript-language-server" "eslint"];
          formatter = {
            command = prettier;
            args = ["--parser" "typescript"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
