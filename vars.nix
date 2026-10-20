{ pkgs, ... }:

{
  # Bootloader configs
  # Options: "systemd-boot", "grub", "refind"
  bootloader = "systemd-boot";

  # Kernel Config
  # Options: pkgs.linuxPackages, pkgs.linuxPackages_latest,
  # pkgs.linuxPackages, or another compatible kernel package set.
  kernelPackages = pkgs.linuxPackages;
  kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
  ];

  # Hardware settings
  gpuDriver = "nvidia";
  enable32Bit = false;

  # Storage Config
  fs = "btrfs";
  enableLvm = false;
  enableEncrypt = false;
  luksPartitionUuid = "PLACEHOLDER";

  # Packages Config
  systemPackages = with pkgs; [
    _7zz
    htop
    firefox

    # Btrfs
    btrfs-progs
  ];

  # Services
  enableOpenSSH = true;
  enableFstrim = true;

  journalMaxUse = "50M";
  enableDocker = true;
  dockerAutoPrune = true;

  # Environment Config
  # Options: "plasma6", "cosmic", "gnome", "budgie", "pantheon", "hyprland", "sway, "niri" etc...
  desktop = "niri";
  displayManager = "sddm";
  excludedPackages = [
    # Only applies if a DE is active.
    # Any package that you don't want, for exemple:
    # pkgs.kdePackages.discover
  ];

  # Locale and keymap
  defaultLocale = "pt_BR.UTF-8";
  consoleKeymap = "br-abnt2";
  xkbLayout = "br";
  xkbVariant = "abnt2";
  timezone = "America/Sao_Paulo";

  # User settings
  username = "heitor-guerra";
  hostname = "computador-heitor";
  extraGroups = [
    "wheel"
    "networkmanager"
  ];
  shell = "zsh";
}
