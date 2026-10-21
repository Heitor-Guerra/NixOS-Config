{ vars, ... }:

{
  boot.supportedFilesystems = [ vars.fs ];
  services.lvm.enable = vars.enableLvm;
}
