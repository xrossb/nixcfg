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

  usePrettier = lang: {
    command = prettier;
    args = ["--parser" lang];
  };
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # html, css, json, eslint
      vscode-langservers-extracted

      # go
      gopls
      golangci-lint-langserver
      delve

      # rust
      rust-analyzer
      rustfmt

      # toml
      taplo
      tombi
    ];

    settings = {
      theme = "github_dark";

      editor = {
        bufferline = "multiple";
        color-modes = true;
        line-number = "relative";
        preview-completion-insert = false;
        rulers = [
          80
          100
        ];
        trim-final-newlines = true;
        trim-trailing-whitespace = true;

        cursor-shape = {
          insert = "bar";
        };

        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "error";
        };

        lsp = {display-progress-messages = true;};

        soft-wrap = {enable = true;};
      };

      keys.insert = {
        "C-space" = "completion";
      };

      keys.normal = {
        space.space = "file_picker";
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
          formatter = usePrettier "typescript";
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = ["typescript-language-server" "eslint"];
          formatter = usePrettier "typescript";
          auto-format = true;
        }
        {
          name = "css";
          formatter = usePrettier "css";
          auto-format = true;
        }
        {
          name = "scss";
          formatter = usePrettier "scss";
          auto-format = true;
        }
      ];
    };
  };
}
