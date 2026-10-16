{ vars, ... }:

{
  services.xserver.enable = true;

  services.desktopManager.${vars.desktopEnvironment}.enable = true;

  services.displayManager.${vars.displayManager} = {
    enable = true;
    wayland.enable = true;
  };

  environment.${vars.desktopEnvironment}.excludePackages = vars.excludedPackages;
}
