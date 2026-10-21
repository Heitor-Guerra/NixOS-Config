# NixOS Configuration

A flake-based NixOS configuration with Home Manager integrated as a NixOS module, declarative disk partitioning through Disko, and a custom bootable installer ISO.

---

## Structure

The repository is organized modularly to keep system definitions clean and maintainable:

- **`flake.nix`**: The main entry point. It pins Nixpkgs and Home Manager inputs, defines system architecture, imports `vars.nix`, and builds the NixOS configuration outputs.
- **`configuration.nix`**: The orchestrator for modules, bringing together system-wide configurations and services.
- **`hardware-configuration.nix`**: THIS FILE IS JUST FOR REFERENCE. It contains machine-specific hardware partitions, filesystem mount points, and device identifiers. Each machine will have a different configuration.
- **`vars.nix`**: Contains global variables that automatically configure system parameters such as the hostname, username, bootloader, kernel, desktop environment, default packages, and locale.
- **`modules/`**: Contains dedicated configuration files for each specific aspect of the system (e.g., networking, storage, security, and services).
- **`home/`**: Contains Home Manager user settings. `home/home.nix` .
  + **`home.nix`**: Acts as the user orchestrator for the dotfiles and user-level packages. 
  + **`packages/`**: Defines dotfiles for packages, using nix language.
  + **`niri/`**: Defines niri and Noctalia configuration.
- **`disko/`**: Declarative disk partitioning and filesystem layouts.
  + **`disk.nix`**: Defines the shared partition table and selects the appropriate root partition layout.
  + **`types/`**: Contains filesystem variants, such as Btrfs, Btrfs with LUKS, ext4, and ext4 with LUKS.
- **`installer/`**: Configuration for the live installer environment and its installation workflow

---

## Requirements

Install NixOS and make sure flakes are enabled. If they are not enabled in your system configuration yet, you can pass the experimental-feature flags to the commands below:

```sh
--extra-experimental-features "nix-command flakes"
```

The flake currently targets:

```sh
system = "x86_64-linux";
```

Change this if you intend to build for another architecture.

---

## Before rebuilding

Before building or installing, review `vars.nix`.

Important settings include:

  +  `hostname`: The hostname and name of your NixOS configuration.
  +  `username`: The user managed by the system and Home Manager.
  +  `mainDevice`: The disk that Disko will partition.
  +  `fs`: The selected filesystem, such as btrfs or ext4.
  +  `enableEncrypt`: Whether the selected filesystem layout uses LUKS encryption.
  +  `enableLvm`: Whether LVM is enabled. Ensure the selected Disko layout actually implements LVM before enabling it.
  +  `gpuDriver`: Hardware graphics configuration.
  +  `desktop` and `displayManager`: Your desktop environment and login manager.

Make sure the selected filesystem, encryption, LVM, bootloader, and hardware settings are compatible.

The mainDevice variable should preferably use a persistent device path, such as `/dev/disk/by-id/...`, rather than a device name that might change between boots.

**Warning**: Disko can erase the target disk. Verify the device identifier before applying a layout. Back up any important data first.

---

## Disk Partitioning with Disko

Disko is integrated into the main NixOS configuration, but ordinary NixOS rebuilds do not automatically repartition or format the disk.

The flake exposes a separate app named disko to apply the selected layout.

Run it from the repository root:

```sh
sudo nix run .#disko
```

The app displays the configured hostname and target device, then asks you to type APPLY before proceeding.

The layout is selected dynamically in `disko/disk.nix` based on the filesystem and encryption variables in vars.nix.

LVM requires corresponding Disko layout definitions; setting `enableLvm = true` alone does not create an LVM layout.

Disko's formatting and partitioning operations are destructive. Only run the app when you intend to create or recreate the selected disk layout.

---

## Build the bootable installer ISO

The flake exposes a custom installer ISO as a package.

Build it with:

```sh
nix build .#installer-iso
```

Inspect the resulting ISO:

```sh
ls -lh result/iso/
```

The ISO provides a bootable live environment intended for installing your configured NixOS system.

The installer environment is separate from the normal desktop configuration. Building the ISO does not install NixOS onto your computer.

The installer is intended to provide the tools required to partition a target disk and install the flake configuration.

After entering the live environment, simply run the following command to install this config:

```sh
sudo install-nixos
```

The installation workflow should:

  1.  Boot into the live installer.
  2.  Establish network connectivity if required.
  3.  Access the flake source and its inputs.
  4.  Select the intended target disk.
  5.  Apply the selected Disko layout.
  6.  Install the selected NixOS configuration.
  7.  Reboot into the installed system.

The ISO must include or be able to access the flake source and all required dependencies. Including the flake source alone does not guarantee that installation can proceed without internet access.

---

## Test and build

From the repository root, you can evaluate and build your configuration using flakes:

```sh
nix flake check
```

Build the NixOS system configuration without activating it:

```sh
nix build .#nixosConfigurations.<HOSTNAME>.config.system.build.toplevel
```

Alternatively, use nixos-rebuild to build the configuration:

```sh
sudo nixos-rebuild build --flake .#<HOSTNAME>
```

---

## Apply the configuration

Test the configuration for the current boot without making it the default for future boots:

```sh
sudo nixos-rebuild test --flake .#<HOSTNAME>
```

Activate it and make it the configuration used for future boots:

```sh
sudo nixos-rebuild switch --flake .#<HOSTNAME>
```

---

## After rebuilding

This config also sets up an user with root access, initially WITHOUT PASSWORD. If you created the user, during NixOS installation, with the same username as set in `vars.nix`, the password you set will remain. Else, please, assign a password for the user immediately after logging in for the first time. You can do this with:

```sh
passwd
```

After it, you might want to enable Secure Boot. It is a security standard that helps make sure your PC boots only trusted software. It's no so simple to do it manually, but there are tools like [Lanzaboote](https://github.com/nix-community/lanzaboote) or [Limine](https://github.com/Limine-Bootloader/Limine) that makes this process easier. If you want to enable it, please read the [wiki page](https://wiki.nixos.org/wiki/Secure_Boot) and follow the guides.

All that remains, due to the reproducibility of NixOS, is the configuration of the Desktop Environment of your choice and set SSH keys (if you want). Unfortunately, these are some things that you can't, reliably, reproduce. 

---

## Usage

After you set everything up, I recommend installing packages and programs to your user, only. You can do this using the mechanism of nix profiles. You can add a package like the following:

```sh
nix profile add nixpkgs#<packageName>
```

or, if the package is Proprietary:

```sh
NIXPKGS_ALLOW_UNFREE=1 nix profile add nixpkgs#<packageName> --impure
```

To remove a package, simply run:

```sh
nix profile remove <packageName>
```
