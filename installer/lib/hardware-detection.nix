''
detect_hardware() {
  echo "Detecting hardware..."
  machine_arch="$(uname -m)"
  case "$machine_arch" in
    x86_64) detected_system="x86_64-linux" ;;
    aarch64) detected_system="aarch64-linux" ;;
    armv7l) detected_system="armv7l-linux" ;;
    *)
      echo "Unsupported architecture: $machine_arch" >&2
      return 1
      ;;
  esac

  cpu_vendor="unknown"
  case "$detected_system" in
    x86_64-linux)
      if grep -qm1 'GenuineIntel' /proc/cpuinfo; then
        cpu_vendor="intel"
      elif grep -qm1 'AuthenticAMD' /proc/cpuinfo; then
        cpu_vendor="amd"
      fi
      ;;
    aarch64-linux|armv7l-linux) cpu_vendor="arm" ;;
  esac

  # Read PCI IDs from sysfs instead of parsing lspci's human-readable output.
  # PCI class 0x03xxxx covers display controllers, including VGA, 3D, and
  # other display-controller subclasses.
  gpu_vendors=()
  gpu_pci_ids=()
  for pci_device in /sys/bus/pci/devices/*; do
    [[ -r "$pci_device/class" && -r "$pci_device/vendor" ]] || continue

    class_code="$(<"$pci_device/class")"
    [[ "$class_code" == 0x03???? ]] || continue

    vendor_id="$(<"$pci_device/vendor")"
    gpu_pci_ids+=("$(basename "$pci_device"):$class_code:$vendor_id")

    case "$vendor_id" in
      0x8086) gpu_vendors+=("intel") ;;
      0x1002) gpu_vendors+=("amd") ;;
      0x10de) gpu_vendors+=("nvidia") ;;
    esac
  done

  if ((''${#gpu_vendors[@]} > 0)); then
    mapfile -t gpu_vendors < <(printf '%s\n' "''${gpu_vendors[@]}" | sort -u)
  else
    gpu_vendors=("unknown")
  fi

  # This is a single-driver setting. Hybrid setups may need manual review.
  if [[ " ''${gpu_vendors[*]} " == *" nvidia "* ]]; then
    gpu_driver="nvidia"
  elif [[ " ''${gpu_vendors[*]} " == *" amd "* ]]; then
    gpu_driver="amdgpu"
  else
    gpu_driver="modesetting"
  fi

  echo "Hardware detected:"
  echo "  Architecture: $detected_system"
  echo "  CPU vendor:   $cpu_vendor"
  echo "  GPU vendors:  ''${gpu_vendors[*]}"
  echo "  GPU driver:   $gpu_driver"
  echo "  PCI display devices: ''${gpu_pci_ids[*]:-none}"
  echo
}
detect_hardware
''
