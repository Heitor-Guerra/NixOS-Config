# Per-machine hardware information.
#
# This file is intentionally empty in the generic installer source. During
# installation, install-nixos writes the detected system architecture, CPU
# vendor, GPU vendors/driver, and selected disk into a writable copy of this
# file. That populated copy is used for installation and copied to /etc/nixos
# on the installed system.
#
# Example of the generated contents:
# {
#   system = "x86_64-linux";
#   cpuVendor = "amd";
#   gpuVendors = [ "amd" "nvidia" ];
#   gpuDriver = "nvidia";
#   mainDevice = "/dev/disk/by-id/nvme-example-disk";
# }
{
  system = "x86_64-linux";
  cpuVendor = "unknown";
  gpuVendors = [ ];
  gpuDriver = "unknown";
  mainDevice = "/dev/disk/by-id/REPLACE";
}
