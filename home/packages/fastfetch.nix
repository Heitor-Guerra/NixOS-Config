{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      # NixOS small ASCII logo
      logo = {
        type = "builtin";
        source = "nixos_small";

        padding = {
          top = 1;
          right = 3;
        };
      };

      display = {
        separator = " : ";

        color = {
          title = "#B4BEFE"; # Lavender
          keys = "#CBA6F7"; # Mauve
          output = "#CDD6F4"; # Text
          separator = "#6C7086"; # Overlay
        };

        key.width = 11;

        percent.type = 3;
      };

      modules = [
        {
          type = "custom";
          key = " ";
          format = "{##A6E3A1}╭─ Hardware ─────────────────────────────────────────╮{#}";
        }

        {
          type = "cpu";
          key = "CPU";
          keyColor = "#A6E3A1";
        }

        {
          type = "gpu";
          key = "GPU";
          keyColor = "#A6E3A1";
        }

        {
          type = "memory";
          key = "Memory";
          keyColor = "#A6E3A1";
        }

        {
          type = "disk";
          key = "Disk";
          keyColor = "#A6E3A1";
          folders = "/";
          format = "{size-used} / {size-total} ({size-percentage}) - {filesystem}";
        }

        {
          type = "custom";
          key = " ";
          format = "{##A6E3A1}╰────────────────────────────────────────────────────╯{#}";
        }

        "break"

        {
          type = "custom";
          key = " ";
          format = "{##F9E2AF}╭─ Software ─────────────────────────────────────────╮{#}";
        }

        {
          type = "os";
          key = "OS";
          keyColor = "#F9E2AF";
          format = "{name} {version}";
        }

        {
          type = "shell";
          key = "Shell";
          keyColor = "#F9E2AF";
        }

        {
          type = "wm";
          key = "WM";
          keyColor = "#F9E2AF";
        }

        {
          type = "custom";
          key = " ";
          format = "{##F9E2AF}╰────────────────────────────────────────────────────╯{#}";
        }

        "break"

        {
          type = "custom";
          key = " ";
          format = "{##F5C2E7}╭─ Uptime / Date ────────────────────────────────────╮{#}";
        }

        {
          type = "uptime";
          key = "Uptime";
          keyColor = "#F5C2E7";
        }

        {
          type = "datetime";
          key = "Date";
          keyColor = "#F5C2E7";
          format = "{day-pretty}/{month-pretty}/{year} {hour-pretty}:{minute-pretty}:{second-pretty}";
        }

        {
          type = "custom";
          key = " ";
          format = "{##F5C2E7}╰────────────────────────────────────────────────────╯{#}";
        }

        "break"

        # Terminal palette
        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };
}
