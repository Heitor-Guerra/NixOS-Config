''
erase_disk() {
  mapfile -t partitions < <(
    lsblk --list --noheadings --paths --output NAME,TYPE "$disk" |
      awk '$2 == "part" { print $1 }'
  )

  echo "Checking and unmounting target partitions..."
  for part in "''${partitions[@]}"; do
    swapoff "$part" 2>/dev/null || true
    part_mm="$(lsblk --nodeps --noheadings --raw --output MAJ:MIN "$part")"
    while read -r mounted_mm target; do
      if [[ "$mounted_mm" == "$part_mm" ]]; then
        echo "Unmounting $target"
        umount -- "$target"
      fi
    done < <(findmnt --raw --noheadings --output MAJ:MIN,TARGET | sort --key=2,2r)
  done

  # Fail closed if any partition on the target disk remains mounted.
  for part in "''${partitions[@]}"; do
    if lsblk --nodeps --noheadings --raw --output MOUNTPOINTS "$part" |
      grep --quiet '[^[:space:]]'; then
      echo "ERROR: $part still appears to be mounted; refusing to erase." >&2
      exit 1
    fi
  done

  echo "Removing old filesystem and partition-table signatures..."
  if ((''${#partitions[@]} > 0)); then
    wipefs --all --force "''${partitions[@]}"
  fi
  wipefs --all --force "$disk"
  blockdev --rereadpt "$disk" || true
  udevadm settle
}
erase_disk
''
