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
    "sway"
  ];
  knownX11WMs = [
    "i3"
    "bspwm"
  ];

  isDE = builtins.elem vars.desktop knownDEs;
  isWaylandWM = builtins.elem vars.desktop knownWaylandWMs;
  isX11WM = builtins.elem vars.desktop knownX11WMs;
  isWM = isWaylandWM || isX11WM;
in
{
  services.xserver.enable = true;

  services.desktopManager = lib.optionalAttrs isDE { ${vars.desktop}.enable = true; };

  programs = lib.optionalAttrs isWaylandWM { ${vars.desktop}.enable = true; };

  services.xserver.windowManager = lib.optionalAttrs isX11WM { ${vars.desktop}.enable = true; };

  services.displayManager.${vars.displayManager} = {
    enable = true;
    wayland.enable = isWaylandWM || isDE;
  };

  environment = lib.optionalAttrs isDE {
    ${vars.desktop}.excludePackages = vars.excludedPackages;
  };

  security.pam.services.swaylock = lib.mkIf isWM { };
}
