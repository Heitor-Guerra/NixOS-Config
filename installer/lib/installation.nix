{
  pkgs,
  vars,
  diskoInstall,
}:
let
  passwordSetupConfig = pkgs.writeText "initial-password-system-config.json" (
    builtins.toJSON {
      systemd.services.set-initial-user-password = {
        description = "Set the initial password for ${vars.username}";
        wantedBy = [ "multi-user.target" ];
        before = [ "display-manager.service" ];
        unitConfig.ConditionPathExists = "/etc/.initial-user-password-hash";
        serviceConfig.Type = "oneshot";
        script = ''
          set -euo pipefail
          password_hash="$(${pkgs.coreutils}/bin/cat /etc/.initial-user-password-hash)"
          if [[ -z "$password_hash" ]]; then
            echo "Initial password hash is empty." >&2
            exit 1
          fi
          printf '%s:%s\n' '${vars.username}' "$password_hash" | ${pkgs.shadow}/bin/chpasswd -e
          ${pkgs.coreutils}/bin/rm -f /etc/.initial-user-password-hash
        '';
      };
    }
  );
in
''
  install_system() {
    echo
    echo "Starting Disko installation..."
    echo

    "${diskoInstall}/bin/disko-install" \
      --mode format \
      --flake "$config_dir#${vars.hostname}" \
      --disk main "$disk_id" \
      --extra-files "$config_dir" etc/nixos \
      --extra-files "$password_hash_file" etc/.initial-user-password-hash \
      --system-config "$(cat ${passwordSetupConfig})"
  }
  install_system
''
