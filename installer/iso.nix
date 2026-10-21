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
      echo
      echo "WARNING: Disko may erase ALL data on this disk."
      echo

      read -r -p "Type ERASE to continue: " confirmation

      if [[ "$confirmation" != "ERASE" ]]; then
        echo "Installation cancelled."
        exit 1
      fi

      exec ${diskoInstall}/bin/disko-install \
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
