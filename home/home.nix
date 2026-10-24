{ pkgs, ... }:

let
  vars = import ./profile-vars.nix { inherit pkgs; };
  languages = vars.languages;

  languagePackages = builtins.concatLists (
    builtins.map (language: language.packages or [ ]) (builtins.attrValues languages)
  );
in
{
  # Import your individual modular program configs explicitly
  imports = [
    ./packages/fastfetch.nix
    ./packages/foot.nix
    ./packages/gram.nix
    ./packages/helix.nix
    ./packages/neovim.nix
    ./packages/yazi.nix
    ./packages/zsh.nix
    ./packages/git.nix
    ./niri/niri.nix
  ];

  # Basic packages you want available in your user environment globally
  home.packages =
    with pkgs;
    [
      nerd-fonts.jetbrains-mono
      kdePackages.breeze
      firefox
      _7zz

      fd
      dust
      duf
      ripgrep
      eza
      bat
      wl-clipboard
    ]
    ++ languagePackages;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Let Home Manager manage itself and your profile
  programs.home-manager.enable = true;
}
