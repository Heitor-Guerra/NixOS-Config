{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      flatpak = "flatpak --user";

      syu = "sudo nixos-rebuild switch --upgrade";
      install = "nix profile install";
      uninstall = "nix profile remove";
    };
  };
}
