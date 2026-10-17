{ lib, vars, ... }:

{
  boot.supportedFilesystems = [ vars.fs ];
  services.lvm.enable = vars.enableLvm;
  boot.initrd.luks.devices = lib.mkIf vars.enableEncrypt {
    cryptlvm.device = "/dev/disk/by-uuid/${vars.luksPartitionUuid}";
  };
}
