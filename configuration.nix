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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise = {
      automatic = true;
      dates = "weekly";
  };
  nix.gc = {
      automatic = true;
      dates = "weekly";
<<<<<<< HEAD
      options = "--delete-older-than 7d";
=======
>>>>>>> cfc95108b867a9db82bc8ba7bafc58f7a927bb05
  };
  system.stateVersion = "26.05";
}
