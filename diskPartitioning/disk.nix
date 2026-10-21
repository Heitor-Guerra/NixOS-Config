{ vars, ... }:

let
  rootPart = import (
    if vars.fs == "btrfs" && vars.enableEncrypt then
      ./types/btrfs-luks.nix
    else if vars.fs == "btrfs" then
      ./types/btrfs.nix
    else if vars.fs == "ext4" && vars.enableEncrypt then
      ./types/ext4-luks.nix
    else if vars.fs == "ext4" then
      ./types/ext4.nix
    else
      throw "Unsupported filesystem: ${vars.fs}"
  );
in
{
  disko.devices.disk.main = {
    type = "disk";

    device = vars.mainDevice;

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          priority = 1;
          size = "500M";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        root = rootPart;
      };
    };
  };
}
