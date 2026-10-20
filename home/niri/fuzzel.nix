{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        font = "JetBrains Mono NF:pixelsize=14";
        dpi-aware = "no";
        prompt = "❯  ";
        layer = "overlay";

        # Layout
        width = 60;
        lines = 6;
        horizontal-pad = 28;
        vertical-pad = 18;
        inner-pad = 10;
        line-height = 30;

        # Search behavior
        match-mode = "fzf";
        fields = "name,generic,comment,categories,filename";
        icon-theme = "Papirus-Dark";
        anchor = "center";
        exit-on-keyboard-focus-loss = true;
      };

      border = {
        width = 2;
        radius = 14;
      };

      colors = {
        background = "1e1e2eee";
        text = "cdd6f4ff";
        prompt = "cba6f7ff";
        placeholder = "6c7086ff";
        input = "cdd6f4ff";
        match = "cba6f7ff";
        selection = "45475aff";
        "selection-text" = "cdd6f4ff";
        "selection-match" = "f5c2e7ff";
        counter = "a6adc8ff";
        border = "cba6f7ff";
      };
    };
  };
}
