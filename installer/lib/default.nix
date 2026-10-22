{ pkgs, vars, diskoInstall }:
{
  banner = import ./banner.nix { inherit vars; };
  hardwareDetection = import ./hardware-detection.nix;
  diskSelection = import ./disk-selection.nix;
  passwordPrompt = import ./password-prompt.nix { inherit vars; };
  configurationPreparation = import ./configuration-preparation.nix;
  diskErasing = import ./disk-erasing.nix;
  installation = import ./installation.nix { inherit pkgs vars diskoInstall; };
}
