{ ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-BTRFS-UUID";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-BTRFS-UUID";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-BTRFS-UUID";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-BTRFS-UUID";
    fsType = "btrfs";
    options = [ "subvol=@log" "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-EFI-UUID";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  swapDevices = [ ];
}
