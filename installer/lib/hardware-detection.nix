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

  gpu_vendor_ids="$(lspci -Dn | awk '$2 ~ /^030[0-2]$/ { split($3, id, ":"); print tolower(id[1]) }' | sort -u)"
  gpu_vendors=()
  if grep -qx '8086' <<< "$gpu_vendor_ids"; then gpu_vendors+=("intel"); fi
  if grep -qx '1002' <<< "$gpu_vendor_ids"; then gpu_vendors+=("amd"); fi
  if grep -qx '10de' <<< "$gpu_vendor_ids"; then gpu_vendors+=("nvidia"); fi
  if ((''${#gpu_vendors[@]} == 0)); then gpu_vendors=("unknown"); fi

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
  echo
}
detect_hardware
''
