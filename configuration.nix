{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/bootloader.nix
    ./modules/kernel.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/security.nix
    ./modules/environment.nix
    ./modules/hardware.nix
    ./modules/default-packages.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/storage.nix
  ];

  system.stateVersion = "26.05";
}
