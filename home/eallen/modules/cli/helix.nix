{
  lib,
  pkgs,
  ...
}: let
  nil = lib.getExe pkgs.nil;
  alejandra = lib.getExe pkgs.alejandra;
  typescript-language-server = lib.getExe pkgs.nodePackages.typescript-language-server;
  eslint = "${pkgs.nodePackages.eslint}/bin/eslint";
  prettier = lib.getExe pkgs.nodePackages.prettier;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "github_dark";
      editor = {
        rulers = [
          80
          100
        ];
        whitespace.render = {
          space = "all";
          tab = "all";
        };
        inline-diagnostics = {
          cursor-line = "info";
          other-lines = "warning";
        };
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

        typescript-language-server.command = typescript-language-server;
        eslint = {
          command = eslint;
          args = ["--stdin"];
        };
      };

      language = [
        {
          name = "nix";
          language-servers = ["nil"];
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
