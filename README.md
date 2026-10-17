# NixOS Configuration

A flake-based NixOS configuration with Home Manager integrated as a NixOS module.

---

## Structure

The repository is organized modularly to keep system definitions clean and maintainable:

- **`flake.nix`**: The main entry point. It pins Nixpkgs and Home Manager inputs, defines system architecture, imports `vars.nix`, and builds the NixOS configuration outputs.
- **`configuration.nix`**: The orchestrator for modules, bringing together system-wide configurations and services.
- **`hardware-configuration.nix`**: THIS FILE IS JUST FOR REFERENCE. It contains machine-specific hardware partitions, filesystem mount points, and device identifiers. Each machine will have a different configuration.
- **`vars.nix`**: Contains global variables that automatically configure system parameters such as the hostname, username, bootloader, kernel, desktop environment, default packages, and locale.
- **`modules/`**: Contains dedicated configuration files for each specific aspect of the system (e.g., networking, storage, security, and services).
- **`home/`**: Contains Home Manager user settings. `home/home.nix` acts as the user orchestrator, while subfolders like `home/packages/` handle individual application configurations.

---

## Requirements

Install NixOS and make sure flakes are enabled. If they are not enabled in your system configuration yet, you can pass the experimental-feature flags to the commands below:

```sh
--extra-experimental-features "nix-command flakes"
```

---

## Before rebuilding

Before using this config, as in (almost) any nix configuration, you need to setup the partitioning and filesystem for the system. You can use the default, from the NixOS live installation, you can set it manually, using a tool like fdisk, or you can use a flake like [Disko](https://github.com/nix-community/disko) to automatize your setup even more. 

After it, review `vars.nix` and `hardware-configuration.nix` to ensure they match your machine. In particular, check the hardware and filesystem settings before applying the configuration. If disk encryption is enabled, replace the luksPartitionUuid placeholder with the appropriate UUID.

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
