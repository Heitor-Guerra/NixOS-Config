{ lib, vars, ... }:

{
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllHardware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = vars.enable32Bit;
  };

  hardware.bluetooth.enable = true;

  services.xserver.videoDrivers = [ vars.gpuDriver ];

  hardware.nvidia = lib.mkIf (vars.gpuDriver == "nvidia") {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = false;
  };

  hardware.cpu.intel.updateMicrocode = (vars.cpuVendor or "unknown") == "intel";
  hardware.cpu.amd.updateMicrocode = (vars.cpuVendor or "unknown") == "amd";
}
