{
  pkgs,
  modulesPath,
  self,
  vars,
  diskoInstall,
  ...
}:

let
  lib = import ./lib { inherit pkgs vars diskoInstall; };

  installNixos = pkgs.writeShellApplication {
    name = "install-nixos";
    runtimeInputs = with pkgs; [
      coreutils
      util-linux
      gawk
      gnugrep
      gnused
      openssl
      pciutils
      gptfdisk
      btrfs-progs
      shadow
      nix
      git
    ];
    text = ''
      set -euo pipefail

      password_hash_file=""
      config_dir=""
      cleanup() {
        if [[ -n "$password_hash_file" ]]; then rm -f "$password_hash_file"; fi
        if [[ -n "$config_dir" ]]; then rm -rf "$config_dir"; fi
      }
      trap cleanup EXIT

      ${lib.banner}
      ${lib.hardwareDetection}
      ${lib.diskSelection}
      ${lib.passwordPrompt}
      ${lib.configurationPreparation}
      ${lib.diskErasing}
      ${lib.installation}
    '';
  };
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Expose the source flake to the live installer. The installer copies it
  # into /run before writing per-machine values, so the Nix store is untouched.
  environment.etc."nixos-config".source = self.outPath;

  environment.systemPackages = with pkgs; [
    git
    vim
    btrfs-progs
    cryptsetup
    lvm2
    gptfdisk
    pciutils
    util-linux
    installNixos
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;
  services.openssh.enable = false;
}
