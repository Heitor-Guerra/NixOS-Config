{ ... }:

{
  size = "100%";

  content = {
    type = "luks";
    name = "cryptroot";

    settings = {
      allowDiscards = true;
    };

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
  };
}
