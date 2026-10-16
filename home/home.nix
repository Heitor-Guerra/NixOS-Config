{ config, pkgs, ... }:

{
  # Import your individual modular program configs explicitly
  imports = [
    ./packages/yazi.nix
    ./packages/foot.nix
    ./packages/gram.nix
    ./packages/zsh.nix
    ./packages/git.nix
  ];

  # Basic packages you want available in your user environment globally
  home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
  ];

  # Let Home Manager manage itself and your profile
  programs.home-manager.enable = true;
}
