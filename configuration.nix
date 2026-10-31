{ ... }:

{
  imports = [
    ./modules/bootloader.nix
    ./modules/default-packages.nix
    ./modules/kernel.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/security.nix
    ./modules/environment.nix
    ./modules/hardware.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/storage.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  system.stateVersion = "26.05";
}
