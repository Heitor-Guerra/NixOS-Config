{ ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        title = "foot";
        font = "JetBrains Mono NF:size=10";
        letter-spacing = "0";
        dpi-aware = "no";
        initial-window-size-pixels = "1100x700";
        include = "/usr/share/foot/themes/catppuccin-macchiato";
      };

      scrollback = {
        lines = "1000";
      };

      url = {
        launch = "xdg-open \${url}";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors-dark = {
        alpha = "0.85";
      };

      csd = {
        size = "30";
        border-width = "2";
        border-color = "ff404040";
      };

      key-bindings = {
        scrollback-up-page = "Shift+Page_Up";
        scrollback-down-page = "Shift+Page_Down";
        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
      };

      mouse-bindings = {
        primary-paste = "BTN_RIGHT";
        select-extend = "BTN_MIDDLE";
      };
    };
  };
}
