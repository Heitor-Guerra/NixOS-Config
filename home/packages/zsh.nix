{ ... }:

{
  programs.zsh = {
    enable = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";

      plugins = [
        "git"
        "sudo"
        "command-not-found"
        "colored-man-pages"
        "extract"
        "docker"
        "foot"
      ];
    };

    # Modern shell experience
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Useful aliases
    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      c = "clear";
      grep = "grep --color=auto";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
      update = "nix flake update";
    };

    # Environment
    history = {
      size = 1000;
      save = 1000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    # Custom initialization
    initContent = ''
      # Better navigation
      setopt AUTO_CD
      setopt INTERACTIVE_COMMENTS

      # Colorful terminal
      export CLICOLOR=1
      export TERM="xterm-256color"

      alias ls="eza --icons --group-directories-first"
      alias tree="eza --tree --icons"

      alias cat="bat"

      # Welcome message
      echo "✨ Welcome back, $(whoami)!"
    '';
  };
}
