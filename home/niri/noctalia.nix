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

      bar = {
        "default" = {
          position = "top";
          enabled = true;
          thickness = 38;
          margin_ends = 10;
          margin_edge = 8;
          widget_spacing = 6;
          background_opacity = 0.94;
          radius = 13;
          border_width = 1;
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_opacity = 0.9;

          start = [
            "launcher"
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
            "tray"
            "notifications"
            "control-center"
            "session"
          ];
        };
      };

      wallpaper = {
        enabled = false;
      };
    };
  };
}
