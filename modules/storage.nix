{ lib, vars, ... }:

{
  boot.supportedFilesystems = [ vars.fs ];

  boot.initrd.services.lvm.enable = vars.enableLvm;

  boot.initrd.kernelModules = lib.optionals vars.enableLvm vars.lvmKernelModules;

  boot.initrd.luks.devices = lib.mkIf vars.enableEncrypt {
    cryptlvm.device = "/dev/disk/by-uuid/${vars.luksPartitionUuid}";
  };
}
