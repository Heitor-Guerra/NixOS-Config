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

    interactiveShellInit = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';
  };
}
