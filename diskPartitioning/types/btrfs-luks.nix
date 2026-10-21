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
