{ pkgs, ... }:

{
  languages = {
    nix = {
      # Packages to install
      # Preferably, place lsp, formatters and linter here
      packages = with pkgs; [
        nil
      ];

      # Fallback that allows download for one lsp. Or definition of arguments and settings.
      lsp = "nil";
    };

    lua = {
      packages = with pkgs; [
        lua
        luarocks
        lua-language-server
      ];

      lsp = "lua-language-server";
      tasks = [
        {
          label = "run lua file";
          command = "lua";
          args = [ "\${GRAM_FILE}" ];
        }
      ];
    };

    # python = {
    #   packages = with pkgs; [
    #     uv
    #     basedpyright
    #     ruff
    #   ];

    #   lsp = "basedpyright";
    #   # Possible to configure the lsp. To not be confused with arguments
    #   settings = {
    #     basedpyright.analysis = {
    #       diagnosticMode = "workspace";
    #     };
    #   };

    #   tasks = [
    #     {
    #       label = "Run Python file";
    #       command = "uv";
    #       args = [
    #         "run"
    #         "\${GRAM_FILE}"
    #       ];
    #     }
    #   ];
    #   debugger = [
    #     {
    #       label = "Debug Python program";
    #       adapter = "Debugpy";
    #       program = "$GRAM_WORKTREE_ROOT/$GRAM_FILE";
    #       request = "launch";
    #     }
    #   ];
    # };

    # c = {
    #   packages = with pkgs; [
    #     clang
    #     cmake
    #   ];

    #   lsp = "clangd";
    #   # Possible to add arguments to call the lsp
    #   arguments = [
    #     "--query-driver=/etc/profiles/per-user/heitor-guerra/bin/clang++"
    #     "--background-index"
    #     "--clang-tidy"
    #   ];

    #   tasks = [
    #     {
    #       label = "Compile C/C++ file";
    #       command = "clang";
    #       args = [
    #         "-g"
    #         "\${GRAM_FILE}"
    #         "-o"
    #         "\${GRAM_DIR}/program"
    #       ];
    #     }
    #   ];

    #   debugger = [
    #     {
    #       label = "Debug C program";
    #       adapter = "CodeLLDB";
    #       program = "$GRAM_WORKTREE_ROOT/program";
    #       request = "launch";
    #     }
    #   ];
    # };

    # rust = {
    #   packages = with pkgs; [
    #     rustup
    #   ];

    #   lsp = "rust-analyzer";
    #   tasks = [
    #     {
    #       label = "Run Rust project";
    #       command = "cargo";
    #       args = [ "run" ];
    #     }
    #     {
    #       label = "Test Rust project";
    #       command = "cargo";
    #       args = [ "test" ];
    #     }
    #   ];

    #   debugger = [
    #     {
    #       label = "Build and debug Rust";
    #       adapter = "CodeLLDB";
    #       build = {
    #         command = "cargo";
    #         args = [ "build" ];
    #       };
    #       program = "$GRAM_WORKTREE_ROOT/target/debug/<your-binary>";
    #       sourceLanguages = [ "rust" ];
    #       request = "launch";
    #     }
    #   ];
    # };

    # go = {
    #   packages = with pkgs; [
    #     go
    #     gopls
    #   ];

    #   lsp = "gopls";
    #   tasks = [
    #     {
    #       label = "Run Go project";
    #       command = "go";
    #       args = [
    #         "run"
    #         "."
    #       ];
    #     }
    #     {
    #       label = "Test Go project";
    #       command = "go";
    #       args = [
    #         "test"
    #         "./..."
    #       ];
    #     }
    #   ];
    # };

    # typescript = {
    #   packages = with pkgs; [
    #     bun
    #     vtsls
    #     eslint
    #   ];

    #   lsp = "vtsls";
    #   tasks = [
    #     {
    #       label = "Run TypeScript file";
    #       command = "bun";
    #       args = [
    #         "run"
    #         "\${GRAM_FILE}"
    #       ];
    #     }
    #   ];
    # };

    # html = {
    #   packages = with pkgs; [
    #     superhtml
    #   ];

    #   lsp = "superhtml";
    # };

    # css = {
    #   packages = with pkgs; [
    #     tailwindcss-language-server
    #   ];

    #   lsp = "tailwindcss-language-server";
    # };

    # bash = {
    #   packages = with pkgs; [
    #     bash-language-server
    #   ];

    #   lsp = "bash-language-server";
    # };

    # json = {
    #   lsp = "json-language-server";
    # };

    # Other languages need their extension to work. Access: (https://wiki.nixos.org/wiki/Gram#Temp_FHS_Environment). For exemple:
    # java = {
    #   packages = with pkgs; [
    #     jdk
    #     maven
    #     jdt-language-server
    #   ];

    #   lsp = "jdtls";
    # };
  };
}
