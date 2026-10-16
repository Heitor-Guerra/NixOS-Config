# NixOS Configuration

A flake-based NixOS configuration with Home Manager integrated as a NixOS module.

---

## Structure

The repository is organized modularly to keep system definitions clean and maintainable:

- **`flake.nix`**: The main entry point. It pins Nixpkgs and Home Manager inputs, defines system architecture, imports `vars.nix`, and builds the NixOS configuration outputs.
- **`configuration.nix`**: The orchestrator for modules, bringing together system-wide configurations and services.
- **`hardware-configuration.nix`**: Contains machine-specific hardware partitions, filesystem mount points, and device identifiers.
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

## Test and build

From the repository root, you can evaluate and build your configuration using flakes:

```sh
nix flake check
```

Build the NixOS system configuration without activating it:

```sh
nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel
```

Alternatively, use nixos-rebuild to build the configuration:

```sh
sudo nixos-rebuild build --flake .
```

---

## Apply the configuration

Test the configuration for the current boot without making it the default for future boots:

```sh
sudo nixos-rebuild test --flake .
```

Activate it and make it the configuration used for future boots:

```sh
sudo nixos-rebuild switch --flake .
```

---

## Before rebuilding

Review `vars.nix` and `hardware-configuration.nix` to ensure they match the target machine. In particular, check the hardware and filesystem settings before applying the configuration. If disk encryption is enabled, replace the luksPartitionUuid placeholder with the appropriate UUID.
