{ vars }:
''
read_initial_password() {
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

  password_hash_file="$(mktemp /run/nixos-initial-password.XXXXXX)"
  chmod 600 "$password_hash_file"
  printf '%s' "$user_password" | openssl passwd -6 -stdin > "$password_hash_file"
  unset user_password user_password_confirm
}
read_initial_password
''
