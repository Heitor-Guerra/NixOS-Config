{ pkgs, lib, ... }:

let
  vars = import ../profile-vars.nix { inherit pkgs; };
  languages = vars.languages;

  languageServers = builtins.foldl' (
    servers: language:
    if !(language ? lsp) || builtins.hasAttr language.lsp servers then
      servers
    else
      servers
      // {
        "${language.lsp}" = {
          command = language.command or language.lsp;
          args = language.arguments or [ ];
        }
        // lib.optionalAttrs (language ? settings) {
          config = language.settings;
        };
      }
  ) { } (builtins.attrValues languages);

  # Generate Helix language definitions.
  helixLanguages = lib.mapAttrsToList (
    name: language:
    {
      name = language.helixName or name;
    }
    // lib.optionalAttrs (language ? lsp) {
      language-servers = [ language.lsp ];
    }
    // lib.optionalAttrs (language ? helixFormatter) {
      formatter = language.helixFormatter;
    }
    // lib.optionalAttrs (language ? helixDebugger) {
      debugger = language.helixDebugger;
    }
  ) languages;

in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_macchiato_transparent";

      editor = {
        # Appearance
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        mouse = true;

        # Navigation
        scrolloff = 8;
        idle-timeout = 250;
        auto-pairs = true;

        # Indentation and gutter
        indent-heuristic = "hybrid";
        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];

        indent-guides = {
          render = true;
          character = "│";
          skip-levels = 0;
        };

        clipboard-provider = "wayland";

        # Preserve the usual right/bottom split behavior.
        # Helix already opens horizontal and vertical splits this way.
        soft-wrap = {
          enable = false;
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        search = {
          smart-case = true;
          wrap-around = true;
        };

        # LSP
        lsp = {
          display-messages = true;
          auto-signature-help = true;
          display-inlay-hints = true;
        };

        # Minimal statusline
        statusline = {
          left = [
            "mode"
            "spinner"
            "diagnostics"
            "file-name"
            "file-modification-indicator"
          ];

          center = [ ];

          right = [
            "selections"
            "position"
            "position-percentage"
            "file-encoding"
          ];

          separator = "│";

          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };

      keys.normal = {
        # Buffer navigation
        "S-l" = "goto_next_buffer";
        "S-h" = "goto_previous_buffer";

        # Window navigation
        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";

        # Leader keybindings
        space = {
          w = ":write";
          q = ":quit";
          Q = ":quit-all";

          b = {
            d = ":buffer-close";
          };
        };
      };
    };

    themes.catppuccin_macchiato_transparent = {
      inherits = "catppuccin_macchiato";
      "ui.background" = { };
    };

    languages = {
      language-server = languageServers;
      language = helixLanguages;
    };
  };
}
