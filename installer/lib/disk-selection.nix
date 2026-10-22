''
select_disk() {
  echo "Available disks:"
  lsblk -d -o NAME,SIZE,TYPE,MODEL
  echo
  read -r -p "Target disk (e.g. /dev/nvme0n1): " disk

  if [[ ! -b "$disk" ]]; then
    echo "Error: '$disk' is not a valid block device." >&2
    return 1
  fi
  disk="$(readlink -f "$disk")"

  if [[ "$(lsblk -dn -o TYPE "$disk")" != "disk" ]]; then
    echo "Error: select a whole disk, not a partition." >&2
    return 1
  fi

  disk_id=""
  for candidate in /dev/disk/by-id/*; do
    [[ -e "$candidate" ]] || continue
    if [[ "$(readlink -f "$candidate")" == "$disk" ]]; then
      disk_id="$candidate"
      break
    fi
  done
  if [[ -z "$disk_id" ]]; then
    echo "No persistent /dev/disk/by-id identifier found for $disk." >&2
    return 1
  fi

  echo
  echo "Selected disk: $disk"
  echo "Persistent ID: $disk_id"
  lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS "$disk"
  echo
  echo "WARNING: ALL data and partitions on this disk will be destroyed."
  read -r -p "Type ERASE to continue: " confirmation
  [[ "$confirmation" == "ERASE" ]] || {
    echo "Installation cancelled."
    return 1
  }
}
select_disk
''
