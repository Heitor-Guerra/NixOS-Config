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
    };

    c = {
      packages = with pkgs; [
        clang
        clang-tools
      ];

      lsp = "clangd";
      # Possible to add arguments to call the lsp
      arguments = [
        "--query-driver=/etc/profiles/per-user/heitor-guerra/bin/clang++"
        "--background-index"
        "--clang-tidy"
      ];
    };

    cpp = {
      packages = with pkgs; [
        clang
        clang-tools
        cmake
      ];

      lsp = "clangd";
      # Possible to add arguments to call the lsp
      arguments = [
        "--query-driver=/etc/profiles/per-user/heitor-guerra/bin/clang++"
        "--background-index"
        "--clang-tidy"
      ];
    };

    cmake = {
      packages = with pkgs; [
        cmake
        gnumake
        conan
        neocmakelsp
      ];

      lsp = "neocmakelsp";
      # Possible to add arguments to call the lsp
      arguments = [ "stdio" ];

      settings = {
        format.enable = true;
        lint.enable = true;
      };
    };

    dockerfile = {
      packages = with pkgs; [
        docker-language-server
      ];

      lsp = "docker-language-server";
      # Possible to add arguments to call the lsp
      arguments = [
        "start"
        "--stdio"
      ];

      settings = {
        telemetry = "off";
      };
    };

    yaml = {
      packages = with pkgs; [
        yaml-language-server
      ];

      lsp = "yaml-language-server";

      arguments = [ "--stdio" ];
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
    # };

    # rust = {
    #   packages = with pkgs; [
    #     rustup
    #   ];

    #   lsp = "rust-analyzer";
    # };

    # go = {
    #   packages = with pkgs; [
    #     go
    #     gopls
    #   ];

    #   lsp = "gopls";
    # };

    # typescript = {
    #   packages = with pkgs; [
    #     bun
    #     vtsls
    #     eslint
    #   ];

    #   lsp = "vtsls";
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
