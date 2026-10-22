{
  pkgs,
  modulesPath,
  self,
  vars,
  diskoInstall,
  ...
}:

let
  installNixos = pkgs.writeShellApplication {
    name = "install-nixos";

    runtimeInputs = [
      pkgs.coreutils
      pkgs.util-linux
      pkgs.gptfdisk
      pkgs.gawk
      pkgs.gnugrep
      pkgs.systemd
    ];

    text = ''
      set -euo pipefail

      echo
      echo "======================================"
      echo "       NixOS Flake Installer"
      echo "======================================"
      echo
      echo "Configuration: ${vars.hostname}"
      echo

      echo "Available disks:"
      lsblk -d -o NAME,SIZE,TYPE,MODEL
      echo

      read -r -p "Target disk (e.g. /dev/nvme0n1): " disk

      if [[ ! -b "$disk" ]]; then
        echo "Error: '$disk' is not a valid block device." >&2
        exit 1
      fi

      disk="$(readlink -f "$disk")"

      echo
      echo "Selected disk: $disk"
      lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS "$disk"
      echo
      echo "WARNING: ALL partitions and data on this disk will be erased."
      echo

      read -r -p "Type ERASE to continue: " confirmation

      if [[ "$confirmation" != "ERASE" ]]; then
        echo "Installation cancelled."
        exit 1
      fi

      # Collect existing partitions on the selected disk.
      mapfile -t partitions < <(
        lsblk --list --noheadings --paths --output NAME,TYPE "$disk" |
          awk '$2 == "part" { print $1 }'
      )

      # Unmount existing filesystems and disable swap on target partitions.
      for part in "''${partitions[@]}"; do
        if swapon --show=NAME --noheadings --raw |
          grep --fixed-strings --line-regexp --quiet "$part"; then
          echo "Disabling swap on $part..."
          swapoff "$part"
        fi

        if findmnt --source "$part" --noheadings --output TARGET \
          >/dev/null 2>&1; then
          echo "Unmounting filesystems on $part..."
          umount --all-targets -- "$part"
        fi

        # Never wipe a partition that still has mounted filesystems.
        if lsblk --nodeps --noheadings --raw --output MOUNTPOINTS "$part" |
          grep --quiet '[^[:space:]]'; then
          echo "ERROR: $part still has mounted filesystems." >&2
          echo "Refusing to erase the disk." >&2
          lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS "$disk" >&2
          exit 1
        fi
      done

      echo
      echo "Removing old filesystem signatures..."

      for part in "''${partitions[@]}"; do
        wipefs --all "$part"
      done

      echo
      echo "Removing the existing partition table..."
      sgdisk --zap-all "$disk"

      echo "Refreshing the kernel's partition information..."
      blockdev --rereadpt "$disk"
      udevadm settle

      echo
      echo "Old disk layout cleared."
      echo "Starting Disko installation..."
      echo

      exec ${diskoInstall}/bin/disko-install \
        --mode format \
        --flake "/etc/nixos-config#${vars.hostname}" \
        --disk main "$disk"
    '';
  };
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Make the flake source available in the live environment.
  environment.etc."nixos-config".source = self.outPath;

  # Tools available from the live USB.
  environment.systemPackages = with pkgs; [
    git
    vim
    btrfs-progs
    cryptsetup
    lvm2
    gptfdisk
    util-linux
    installNixos
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.networkmanager.enable = true;

  services.openssh.enable = false;
}
