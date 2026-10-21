{ ... }:

{
  size = "100%";

  content = {
    type = "btrfs";
    extraArgs = [ "-f" ];

    subvolumes = {
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
