{ pkgs, ... }:

{
  # Bootloader configs
  # Options: "systemd-boot", "grub", "refind"
  bootloader = "systemd-boot";
  # Used only by GRUB for UEFI installations.
  grubDevice = "nodev";

  # Kernel Config
  # Options: pkgs.linuxPackages, pkgs.linuxPackages_latest,
  # pkgs.linuxPackages, or another compatible kernel package set.
  kernelPackages = pkgs.linuxPackages;
  kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "libahci.ignore_sss=1"
  ];

  # Hardware settings
  gpuDriver = "nvidia";

  # Security configs
  enableSudo = true;

  # Storage Config
  fs = "btrfs";
  # Logical Volume Manager
  enableLvm = false;
  lvmKernelModules = [
    "dm_mod"
  ];
  enableEncrypt = false;
  luksPartitionUuid = "PLACEHOLDER";

  # Packages Config
  systemPackages = with pkgs; [
    _7zz
    gram
    nano
    foot
    git
    htop
    yazi
    firefox

    # Programming Tools
    lua
    luarocks
    uv
    bun

    # Btrfs and LVM management
    btrfs-progs
    # lvm2
  ];

  # Services
  enableOpenSSH = true;
  enableFstrim = true;

  journalMaxUse = "50M";
  enableDocker = true;
  dockerAutoPrune = true;

  # Environment Config
  # Options: "plasma6", "cosmic", "gnome"
  desktopEnvironment = "plasma6";
  displayManager = "sddm";
  excludedPackages = with pkgs.kdePackages; [
    plasma-browser-integration
    kcalc
    ktnef
    merkuro
    kcharselect
    ksystemlog
    isoimagewriter
    partitionmanager
    kolourpaint
    kcolorchooser
    kontact
    kmail
    ark
    elisa
    kdepim-runtime
    dolphin
    discover
    kate
    qrca
    kwrited
    kwalletmanager
    kwallet
    gwenview
    okular
    konsole
    kmahjongg
    kmines
    konversation
    kpat
    ksudoku
    ktorrent
  ];

  # Locale and keymap
  defaultLocale = "pt_BR.UTF-8";
  consoleKeymap = "br-abnt2";
  xkbLayout = "br";
  xkbVariant = "abnt2";
  timezone = "America/Sao_Paulo"

  # User settings
  username = "heitor-guerra";
  hostname = "computador-heitor";
  extraGroups = [
    "wheel"
    "networkmanager"
  ];
  shell = "zsh";
  enableSteam = false;
}
