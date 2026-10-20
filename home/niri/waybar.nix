{ ... }:

{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 38;
      spacing = 6;
      margin-top = 8;
      margin-left = 10;
      margin-right = 10;

      modules-left = [
        "custom/launcher"
        "niri/workspaces"
      ];

      modules-center = [
        "niri/window"
      ];

      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "clock"
        "tray"
        "custom/power"
      ];

      "custom/launcher" = {
        format = "";
        tooltip = false;
        on-click = "fuzzel";
      };

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "default" = "○";
        };
        disable-scroll = false;
        all-outputs = true;
      };

      "niri/window" = {
        format = "{title}";
        max-length = 55;
        separate-outputs = true;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons = {
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          headphone = "󰋋";
          headset = "󰋎";
        };
        on-click = "pavucontrol";
        scroll-step = 5;
      };

      network = {
        interval = 5;
        format-wifi = "󰤨 {essid}";
        format-ethernet = "󰈀 connected";
        format-disconnected = "󰤭 offline";
        tooltip = true;
      };

      "custom/power" = {
        format = "";
        tooltip = true;
        tooltip-format = "Power menu";
        on-click = "power-menu";
      };

      battery = {
        states = {
          warning = 20;
          critical = 10;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        tooltip = true;
      };

      clock = {
        interval = 60;
        format = "󰥔  {:%a %d %b  ·  %H:%M}";
        tooltip-format = "<big>{:%A, %d %B %Y}</big>\n<tt>{calendar}</tt>";
      };

      tray = {
        icon-size = 16;
        spacing = 10;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      window#waybar > box {
        background: rgba(30, 30, 46, 0.94);
        border: 1px solid #313244;
        border-radius: 13px;
        padding: 0 8px;
      }

      #custom-launcher {
        color: #cba6f7;
        font-size: 17px;
        padding: 0 12px;
      }

      #workspaces {
        padding: 4px;
      }

      #workspaces button {
        color: #a6adc8;
        background: transparent;
        padding: 0 9px;
        margin: 3px 2px;
        border-radius: 8px;
        transition: all 150ms ease;
      }

      #workspaces button.active {
        color: #1e1e2e;
        background: #cba6f7;
      }

      #workspaces button:hover {
        background: #45475a;
        color: #cdd6f4;
        box-shadow: none;
      }

      #window {
        color: #bac2de;
        padding: 0 12px;
      }

      #cpu, #memory, #pulseaudio, #network,
      #battery, #clock, #tray, #custom-power {
        padding: 0 10px;
        margin: 5px 2px;
        background: #313244;
        border-radius: 8px;
      }

      #cpu { color: #89b4fa; }
      #memory { color: #cba6f7; }
      #pulseaudio { color: #94e2d5; }
      #network { color: #89dceb; }
      #battery { color: #a6e3a1; }
      #clock { color: #f5c2e7; }

      #custom-power {
        color: #f38ba8;
        margin-right: 4px;
      }

      #battery.warning { color: #f9e2af; }
      #battery.critical { color: #f38ba8; }
      #pulseaudio.muted { color: #6c7086; }
      #network.disconnected { color: #f38ba8; }

      tooltip {
        background: #1e1e2e;
        color: #cdd6f4;
        border: 1px solid #cba6f7;
        border-radius: 8px;
        padding: 8px;
      }
    '';
  };
}
