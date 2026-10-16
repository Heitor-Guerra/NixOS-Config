{ vars, ... }:

{
  services.xserver.enable = true;

  services.desktopManager.${vars.desktopEnvironment}.enable = true;
  services.displayManager.${vars.displayManager}.enable = true;
  services.displayManager.${vars.displayManager}.wayland.enable = true;

  environment.${vars.desktopEnvironment}.excludePackages = vars.excludedPackages;
}
