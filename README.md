# NixOS Configuration

A flake-based NixOS configuration with Home Manager integrated as a NixOS module, declarative disk partitioning through Disko, and a custom bootable installer ISO.

---

## Structure

The repository is organized modularly to keep system definitions clean and maintainable:

- **`flake.nix`**: The main entry point. It pins Nixpkgs and Home Manager inputs, defines system architecture, imports `vars.nix`, and builds the NixOS configuration outputs.
- **`configuration.nix`**: The orchestrator for modules, bringing together system-wide configurations and services.
- **`variables/vars.nix`** — holds the reusable system settings, including hostname, username, filesystem, encryption and LVM options, bootloader, kernel, graphics driver, desktop environment, display manager, packages, services, locale, and keymap.
- **`variables/hardware-info.nix`** — holds per-machine hardware details used by the flake, such as the Nix system architecture, CPU vendor, detected GPU vendor information and driver choice, and selected installation disk. The template can be empty in the repository; the installer writes the detected values into a writable copy before installing. **If using the system rebuild, instead of custom iso, please configure this.**
- **`modules/`**: Contains dedicated configuration files for each specific aspect of the system (e.g., networking, storage, security, and services).
- **`home/`**: Contains Home Manager user settings. `home/home.nix` .
  + **`home.nix`**: Acts as the user orchestrator for the dotfiles and user-level packages. 
  + **`packages/`**: Defines dotfiles for packages, using nix language.
  + **`niri/`**: Defines niri and Noctalia configuration.
- **`disko/`**: Configuration for filesystem layouts and disk partitioning. Can .
- **`installer/`**: Configuration for the live installer environment and its installation workflow

---

## Requirements

Install NixOS and make sure flakes are enabled. If they are not enabled in your system configuration yet, you can pass the experimental-feature flags to the commands below:

```sh
--extra-experimental-features "nix-command flakes"
```

---

## Before rebuilding

Before building or installing, review `vars.nix`.

Important settings include:

  +  `hostname`: The hostname and name of your NixOS configuration.
  +  `username`: The user managed by the system and Home Manager.
  +  `fs`: The selected filesystem, such as btrfs or ext4.
  +  `enableEncrypt`: Whether the selected filesystem layout uses LUKS encryption.
  +  `enableLvm`: Whether LVM is enabled. Ensure the selected Disko layout actually implements LVM before enabling it.
  +  `desktop` and `displayManager`: Your desktop environment and login manager.

Make sure the selected filesystem, encryption, LVM, bootloader, and hardware settings are compatible.

**Warning**: Disko can erase the target disk. Verify the device identifier before applying a layout. Back up any important data first.

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
