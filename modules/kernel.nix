{ modulesPath, vars, ... }:

{
  boot.kernelPackages = vars.kernelPackages;
  boot.kernelParams = vars.kernelParams;

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [ ];

  boot.kernelModules =
    if vars.cpuVendor == "amd" then
      [ "kvm-amd" ]
    else if vars.cpuVendor == "intel" then
      [ "kvm-intel" ]
    else
      [ ];

  boot.extraModulePackages = [ ];
}
