{
  lib,
  pkgs,
  modulesPath,
  self,
  vars,
  diskoInstall,
  ...
}:

let
  passwordHashPath = "/etc/.initial-user-password-hash";

  # This transient module runs once on the first boot. The password hash is
  # copied to the installed filesystem, not embedded in the Nix store.
  passwordSetupConfig = builtins.toJSON {
    systemd.services.set-initial-user-password = {
      description = "Set the initial password for ${vars.username}";
      wantedBy = [ "multi-user.target" ];
      before = [ "display-manager.service" ];
      unitConfig.ConditionPathExists = passwordHashPath;
      serviceConfig.Type = "oneshot";
      script = ''
        set -euo pipefail
        password_hash="$(${pkgs.coreutils}/bin/cat ${passwordHashPath})"

        if [[ -z "$password_hash" ]]; then
          echo "Initial password hash is empty." >&2
          exit 1
        fi

        printf '%s:%s\n' '${vars.username}' "$password_hash" \
          | ${pkgs.shadow}/bin/chpasswd -e

        ${pkgs.coreutils}/bin/rm -f ${passwordHashPath}
      '';
    };
  };

  installNixos = pkgs.writeShellApplication {
    name = "install-nixos";

    runtimeInputs = [
      pkgs.coreutils
      pkgs.util-linux
      pkgs.gptfdisk
      pkgs.gawk
      pkgs.openssl
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
      echo "User: ${vars.username}"
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
      echo "WARNING: ALL data and partitions on this disk will be destroyed."
      echo

      read -r -p "Type ERASE to continue: " confirmation

      if [[ "$confirmation" != "ERASE" ]]; then
        echo "Installation cancelled."
        exit 1
      fi

      # Ask for the password before changing the disk, so a typo/cancel does
      # not happen after partitioning starts.
      while true; do
        read -r -s -p "Password for ${vars.username}: " user_password
        printf '\n'
        read -r -s -p "Confirm password: " user_password_confirm
        printf '\n'

        if [[ -z "$user_password" ]]; then
          echo "Password cannot be empty. Try again." >&2
        elif [[ "$user_password" != "$user_password_confirm" ]]; then
          echo "Passwords do not match. Try again." >&2
        else
          break
        fi
      done

      # Hash in /run (tmpfs). The plaintext password is never put in the
      # Nix store or passed as a command-line argument.
      password_hash_file="$(mktemp /run/nixos-initial-password.XXXXXX)"
      chmod 600 "$password_hash_file"
      trap 'rm -f "$password_hash_file"' EXIT
      printf '%s' "$user_password" | openssl passwd -6 -stdin > "$password_hash_file"
      unset user_password user_password_confirm

      echo
      echo "Unmounting any mounted filesystems from the selected disk..."

      mapfile -t partitions < <(
        lsblk --list --noheadings --paths --output NAME,TYPE "$disk" |
          awk '$2 == "part" { print $1 }'
      )

      for part in "''${partitions[@]}"; do
        # Disable active swap if a target partition is being used as swap.
        swapoff "$part" 2>/dev/null || true

        # Match mountpoints by major:minor so Btrfs subvolumes are included.
        part_mm="$(lsblk --nodeps --noheadings --raw --output MAJ:MIN "$part")"
        while read -r mounted_mm target; do
          if [[ "$mounted_mm" == "$part_mm" ]]; then
            echo "Unmounting $target"
            umount -- "$target"
          fi
        done < <(findmnt --raw --noheadings --output MAJ:MIN,TARGET | sort --key=2,2r)
      done

      echo "Removing old filesystem and partition-table signatures..."
      if [[ "''${#partitions[@]}" -gt 0 ]]; then
        wipefs --all "''${partitions[@]}"
      fi
      wipefs --all "$disk"
      blockdev --rereadpt "$disk"
      udevadm settle

      echo
      echo "Starting Disko installation..."
      echo

      "${diskoInstall}/bin/disko-install" \
        --mode format \
        --flake "/etc/nixos-config#${vars.hostname}" \
        --disk main "$disk" \
        --extra-files "${self.outPath}" etc/nixos \
        --extra-files "$password_hash_file" etc/.initial-user-password-hash \
        --system-config ${lib.escapeShellArg passwordSetupConfig}
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
