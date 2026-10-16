{ lib, vars, ... }:

{
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllHardware = true;
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  services.xserver.videoDrivers = [ vars.gpuDriver ];

  hardware.nvidia =  lib.mkIf (vars.gpuDriver == "nvidia") {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
}
