{ ... }:

{
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      battery = {
        warning_threshold = 20;
      };

      bar = {
        "default" = {
          position = "top";
          enabled = true;
          thickness = 38;
          margin_ends = 10;
          margin_edge = 8;
          widget_spacing = 6;
          background_opacity = 0.9;
          radius = 13;
          border_width = 1;
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_opacity = 0.9;

          start = [
            "launcher"
            "notifications"
            "tray"
            "workspaces"
          ];

          center = [
            "active_window"
          ];

          end = [
            "volume"
            "network"
            "battery"
            "clock"
            "control-center"
            "session"
          ];
        };
      };

      wallpaper = {
        enabled = true;
        directory = "/home/heitor-guerra/Pictures/Imagens";
        fill_mode = "fill";
        default = {
          path = "/home/heitor-guerra/Pictures/Imagens/Tela_Padrao.jpg";
        };
      };

      shell = {
        launcher = {
          categories = true;
          show_icons = true;
          show_app_origin_indicator = true;
          compact = false;
          app_grid = false;
          show_app_actions = false;
          sort_by_usage = true;
          pinned = [ ];
          fetch_exchange_rates = false;
          global = true;
        };
      };

      lockscreen = {
        enabled = true;
        lock_before_suspend = true;
        grace_period_seconds = 0;
        fingerprint = true;
        blurred_desktop = false;
        transition = [
          "fade"
          "wipe"
          "zoom"
        ];
        transition_duration = 500;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
        wallpaper = "/home/heitor-guerra/Pictures/Imagens/Tela_Padrao.jpg";
      };

      idle = {
        pre_action_fade_seconds = 1.0;

        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 120;
          };

          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 150;
          };

          suspend = {
            action = "suspend";
            enabled = true;
            timeout = 300;
          };
        };
      };
    };
  };
}
