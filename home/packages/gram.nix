{ ... }:

{
  programs.gram = {
    enable = true;

    settings = {
      node = {
        ignore_system_version = true;
        allow_prettier_download = true;
        allow_npm_install = true;
        allow_binary_download = true;
      };

      tab_bar.show = true;

      title_bar = {
        show_menus = false;
        show_onboarding_banner = false;
        show_project_items = true;
        show_branch_name = true;
        show_branch_icon = true;
      };

      status_bar = {
        active_language_button = false;
        active_file = false;
        show = true;
        cursor_position_button = false;
      };

      search.button = false;
      tab_size = 2;
      smooth_scroll.enabled = true;
      autosave = "on_window_change";
      ui_font_weight = 300.0;
      buffer_font_weight = 300.0;
      buffer_font_family = "JetBrainsMono Nerd Font";
      restore_on_startup = "last_session";
      when_closing_with_no_tabs = "close_window";

      lsp = {
        "lua-language-server" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };

        "vtsls" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };

        "eslint" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };

        "tailwindcss-language-server" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };

        "ruff" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };

        "basedpyright" = {
          binary = {
            enable_auto_updates = true;
            allow_binary_download = true;
          };
          enable_lsp_tasks = true;
        };
      };

      project_panel = {
        hide_hidden = true;
        hide_root = false;
        git_status = false;
        hide_gitignore = false;
        button = true;
        file_icons = true;
        folder_icons = true;
      };

      base_keymap = "Minimal";
      buffer_font_size = 13.0;

      theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
    };

    keymaps = [
      {
        context = "Workspace";
        bindings."ctrl-s" = "workspace::Save";
      }
      {
        context = "Workspace";
        bindings."shift-s" = "workspace::SaveAs";
      }
      {
        context = "Workspace";
        bindings."alt-s" = "workspace::SaveAll";
      }
      {
        context = "((Editor && jupyter) && !ContextEditor)";
        bindings."shift-enter" = "repl::Run";
      }
      {
        bindings."ctrl-/" = "editor::ToggleComments";
      }
      {
        context = "Workspace";
        bindings."ctrl-shift-f" = "pane::DeploySearch";
      }
      {
        bindings."ctrl-f" = "buffer_search::Deploy";
      }
      {
        context = "Terminal";
        bindings."ctrl-shift-f" = null;
      }
      {
        bindings."alt-down" = "editor::AddSelectionBelow";
      }
      {
        bindings."alt-up" = "editor::AddSelectionAbove";
      }
      {
        bindings."alt-j" = "editor::SelectPrevious";
      }
      {
        bindings."alt-k" = "editor::SelectNext";
      }
      {
        bindings."alt-l" = "editor::SelectAllMatches";
      }
      {
        bindings.f2 = "task::Spawn";
      }
    ];

    tasks = [
      {
        label = "run lua file";
        command = "lua";
        args = [ "\${GRAM_FILE}" ];
      }

      {
        label = "Python: Run";
        command = "python3";
        args = [ "$GRAM_FILE" ];
      }
    ];

    debugger = [
      {
        label = "Python: Debug";
        adapter = "Debugpy";
        request = "launch";
        program = "$GRAM_FILE";
      }
    ];
  };
}
