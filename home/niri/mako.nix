{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      font = "JetBrainsMono Nerd Font 11";
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";

      border-size = 2;
      border-radius = 12;
      padding = 14;
      margin = 10;
      width = 360;
      height = 140;
      outer-margin = 8;

      anchor = "top-right";
      layer = "overlay";
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";
      icons = true;
      markup = true;
      actions = true;
      history = true;

      "urgency=low" = {
        border-color = "#45475a";
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = "#cba6f7";
        default-timeout = 5000;
      };

      "urgency=critical" = {
        border-color = "#f38ba8";
        background-color = "#30202b";
        text-color = "#f5c2e7";
        default-timeout = 0;
      };
    };
  };
}
