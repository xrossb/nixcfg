{
  lib,
  pkgs,
  ...
}: let
  nil = lib.getExe pkgs.nil;
  nixd = lib.getExe pkgs.nixd;
  alejandra = lib.getExe pkgs.alejandra;
  typescript-language-server = lib.getExe pkgs.typescript-language-server;
  oxlint = lib.getExe pkgs.oxlint;
  oxfmt = lib.getExe pkgs.oxfmt;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [vscode-langservers-extracted];
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
        nixd.command = nixd;

        typescript-language-server.command = typescript-language-server;
        oxlint = {
          command = oxlint;
          args = ["--lsp"];
        };
        oxfmt = {
          command = oxfmt;
          args = ["--lsp"];
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
          language-servers = ["typescript-language-server" "oxlint" "oxfmt"];
          formatter = {
            command = oxfmt;
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = ["typescript-language-server" "oxlint" "oxfmt"];
          formatter = {
            command = oxfmt;
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
