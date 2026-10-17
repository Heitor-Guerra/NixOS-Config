{ lib, vars, ... }:

{
  boot.loader.${vars.bootloader} = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.grub = lib.mkIf (vars.bootloader == "grub") {
    efiSupport = true;
    device = vars.grubDevice;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.timeout = 0;

}
