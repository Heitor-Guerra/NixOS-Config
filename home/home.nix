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
    ./packages/yazi.nix
    ./packages/foot.nix
    ./packages/gram.nix
    ./packages/zsh.nix
    ./packages/git.nix
  ];

  # Basic packages you want available in your user environment globally
  home.packages =
    with pkgs;
    [
      nerd-fonts.jetbrains-mono

      eza
      bat
    ]
    ++ languagePackages;

  # Let Home Manager manage itself and your profile
  programs.home-manager.enable = true;
}
