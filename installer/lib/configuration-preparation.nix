''
prepare_configuration() {
  config_dir="$(mktemp -d /run/nixos-config.XXXXXX)"
  cp -R /etc/nixos-config/. "$config_dir/"
  chmod -R u+rwX "$config_dir"

  if [[ ! -d "$config_dir/variables" ]]; then
    echo "Expected $config_dir/variables to exist." >&2
    return 1
  fi

  gpu_vendors_nix=""
  for vendor in "''${gpu_vendors[@]}"; do
    gpu_vendors_nix+=" \"$vendor\""
  done

  cat > "$config_dir/variables/hardware-info.nix" <<EOF_HARDWARE
{
  system = "$detected_system";
  cpuVendor = "$cpu_vendor";
  gpuVendors = [ ''${gpu_vendors_nix} ];
  gpuDriver = "$gpu_driver";
  mainDevice = "$disk_id";
}
EOF_HARDWARE

  # Parse the generated file before any destructive disk operation.
  nix-instantiate --parse "$config_dir/variables/hardware-info.nix" >/dev/null
  echo "Generated hardware information at $config_dir/variables/hardware-info.nix"
}
prepare_configuration
''
