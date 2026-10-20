{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      color = "1e1e2e";
      font = "JetBrainsMono Nerd Font";
      font-size = 16;

      indicator-radius = 110;
      indicator-thickness = 8;
      line-color = "1e1e2e";
      separator-color = "00000000";

      inside-color = "313244";
      inside-clear-color = "313244";
      inside-caps-lock-color = "313244";

      ring-color = "45475a";
      ring-clear-color = "89b4fa";
      ring-caps-lock-color = "f9e2af";
      ring-ver-color = "cba6f7";
      ring-wrong-color = "f38ba8";

      key-hl-color = "a6e3a1";
      bs-hl-color = "f38ba8";

      text-color = "cdd6f4";
      text-clear-color = "cdd6f4";
      text-caps-lock-color = "f9e2af";
      text-ver-color = "cba6f7";
      text-wrong-color = "f38ba8";

      show-failed-attempts = true;
      indicator-idle-visible = false;
      clock = true;
      timestr = "%H:%M";
      datestr = "%A, %d %B";
      screenshots = false;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
    };
  };
}
