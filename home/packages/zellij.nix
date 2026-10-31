{ ... }:

{
  programs.zellij = {
    enable = true;

    # Keep Zellij manually launched with `zellij`.
    # Set to true to enable Zsh auto-start integration.
    enableZshIntegration = false;

    settings = {
      # Appearance
      theme = "catppuccin-mocha";
      default_layout = "compact";
      pane_frames = true;
      simplified_ui = false;
      rounded_corners = true;

      default_shell = "zsh";

      # Mouse and clipboard
      mouse_mode = true;
      copy_on_select = true;

      # Scrollback
      scroll_buffer_size = 10000;

      # Session behavior
      on_force_close = "quit";
      session_serialization = true;
    };
  };
}
