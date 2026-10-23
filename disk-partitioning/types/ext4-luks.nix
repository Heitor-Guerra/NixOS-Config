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
      type = "filesystem";
      format = "ext4";
      mountpoint = "/";
    };
  };
}
