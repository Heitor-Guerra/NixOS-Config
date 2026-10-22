{ ... }:

{
  size = "100%";

  content = {
    type = "btrfs";
    extraArgs = [ "-f" ];

    subvolumes = {
      "/root" = {
        mountpoint = "/";
        mountOptions = [ "compress=zstd" ];
      };

      "/home" = {
        mountpoint = "/home";
        mountOptions = [ "compress=zstd" ];
      };

      "/nix" = {
        mountpoint = "/nix";
        mountOptions = [
          "compress=zstd"
          "noatime"
        ];
      };
    };
  };
}
