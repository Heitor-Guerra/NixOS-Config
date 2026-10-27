{ lib, vars, ... }:

let
  # Define what counts as a Desktop Environment vs a Window Manager
  knownDEs = [
    "plasma6"
    "cosmic"
    "gnome"
    "budgie"
    "pantheon"
  ];
  knownWaylandWMs = [
    "niri"
    "hyprland"
    "river"
    "sway"
  ];
  knownX11WMs = [
    "i3"
    "fluxbox"
    "xmonad"
    "bspwm"
  ];

  isDE = builtins.elem vars.desktop knownDEs;
  isWaylandWM = builtins.elem vars.desktop knownWaylandWMs;
  isX11WM = builtins.elem vars.desktop knownX11WMs;
in
{
  services.xserver.enable = true;

  services.desktopManager = lib.optionalAttrs isDE { ${vars.desktop}.enable = true; };

  programs = lib.optionalAttrs isWaylandWM { ${vars.desktop}.enable = true; };

  services.xserver.windowManager = lib.optionalAttrs isX11WM { ${vars.desktop}.enable = true; };

  services.displayManager.${vars.displayManager}.enable = true;
}
