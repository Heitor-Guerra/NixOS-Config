# This file should not be used. It's just reference if you want to change yours. If you do not know how to procede, you the hardware-configuration.nix generated automatically
{ config, lib, pkgs, modulesPath, vars, ... }:

{

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a0897340-d2b0-4ed7-8977-f27c3ac758da";
    fsType = vars.fs;
    options = [ "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/a0897340-d2b0-4ed7-8977-f27c3ac758da";
    fsType = vars.fs;
    options = [ "subvol=home" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/a0897340-d2b0-4ed7-8977-f27c3ac758da";
    fsType = vars.fs;
    options = [ "subvol=nix" "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/18D9-413E";
    fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = true;
}

