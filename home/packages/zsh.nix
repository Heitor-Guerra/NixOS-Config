{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
  
      plugins = [
        {
          name = "you-should-use";
          src = pkgs.zsh-you-should-use;
          file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        }
      ];

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
          "zoxide"
        ];
      };

      # Modern shell experience
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Useful aliases
      shellAliases = {
        # Navigation and file listing
        c = "clear";
        ls = "eza --icons --group-directories-first";
        ll = "eza -lah --icons --group-directories-first";
        la = "eza -a --icons --group-directories-first";
        tree = "eza --tree --icons";
        cat = "bat";

        # Search
        grep = "rg --color=auto";
        f = "fd";

        # System monitoring and disk usage
        htop = "btop";
        du = "dust";
        df = "duf";

        # NixOS workflows
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
        update = "nix flake update";
      };

      # Environment
      history = {
        size = 10000;
        save = 10000;
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      # Custom initialization
      initContent = ''
        # Better navigation
        setopt AUTO_CD
        setopt INTERACTIVE_COMMENTS

        # Hide dotfiles and underscore-prefixed entries from completion
        zstyle ':completion:*' ignored-patterns '_*'

        # Welcome message
        echo "✨ Welcome back, $(whoami)!"
      '';
    };

    # Fuzzy finder and shell keybindings
    fzf = {
      enable = true;
      enableZshIntegration = true;
      historyWidget.command = "";
      defaultCommand = "fd --type f --hidden --follow --exclude .git";

      defaultOptions = [
        "--height=40%"
        "--layout=reverse"
        "--border"
      ];
    };

    # Smarter directory navigation
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # Searchable shell history
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
