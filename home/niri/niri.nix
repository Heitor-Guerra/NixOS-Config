{ pkgs, ... }:

{
  imports = [
    ./fuzzel.nix
    ./swaylock.nix
    ./waybar.nix
    ./mako.nix
    ./swayidle.nix
    ./udiskie.nix
    # ./noctalia.nix
  ];

  home.packages = with pkgs; [
    swaybg
    xwayland-satellite
    playerctl
    brightnessctl
    wl-clipboard
    libnotify
    pavucontrol
    papirus-icon-theme
  ];

  services.polkit-gnome.enable = true;
  services.gnome-keyring.enable = true;

  # Manage Niri's config directly as valid KDL, bypassing the broken HM translator
  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots from %Y-%m-%d %H-%M-%S.png"

    hotkey-overlay {
        skip-at-startup
    }

    cursor {
        xcursor-theme "Adwaita"
        xcursor-size 18
        hide-when-typing
    }

    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "udiskie" "--tray"
    spawn-at-startup "swaybg" "-i" "/home/heitor-guerra/Pictures/Imagens/Tela_Padrao.jpg" "-m" "fill"

    input {
        keyboard {
            repeat-rate 50
            repeat-delay 300
        }

        touchpad {
            tap
            natural-scroll
            dwt
        }

        mouse {
            accel-profile "adaptive"
        }

        focus-follows-mouse
        warp-mouse-to-focus
    }

    layout {
        gaps 12

        center-focused-column "on-overflow"

        default-column-width {
            proportion 0.5
        }

        focus-ring {
            width 2
            active-color "#cba6f7"
            inactive-color "#45475a"
        }

        border {
            off
        }

        shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
            color "#00000055"
        }
    }

    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    binds {
        // Applications
        Mod+Return { spawn "foot"; }
        Mod+D { spawn "fuzzel"; }
        Mod+E { spawn "foot" "yazi"; }
        Mod+B { spawn "firefox"; }
        Mod+V { spawn "pavucontrol"; }

        // Window management
        Mod+Q { close-window; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+W { toggle-column-tabbed-display; }

        // Focus — arrow keys
        Mod+Left { focus-column-left; }
        Mod+Down { focus-window-down; }
        Mod+Up { focus-window-up; }
        Mod+Right { focus-column-right; }

        // Move windows
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+Right { move-column-right; }

        // Resize columns
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Minus { set-column-width "-5%"; }
        Mod+Equal { set-column-width "+5%"; }
        Mod+Shift+Minus { set-window-height "-5%"; }
        Mod+Shift+Equal { set-column-height "+5%"; }

        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }

        Mod+Page_Down { focus-workspace-down; }
        Mod+Page_Up { focus-workspace-up; }

        // Overview and column navigation
        Mod+Tab { toggle-overview; }
        Mod+Comma { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        // Screenshots
        Print { screenshot; }
        Mod+Print { screenshot-screen; }
        Mod+Shift+Print { screenshot-window; }

        // Audio
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        // Media keys
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }

        // Brightness
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }

        // Session
        Mod+Alt+L { spawn "swaylock"; }
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }
    }
  '';
}
