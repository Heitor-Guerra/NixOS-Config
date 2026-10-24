{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      mini-nvim
    ];

    initLua = ''
      -- Leader keys
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Appearance
      vim.opt.termguicolors = true
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.signcolumn = "yes"
      vim.opt.cursorline = true
      vim.opt.showmode = false
      vim.opt.laststatus = 3

      -- Smooth navigation
      vim.opt.scrolloff = 8
      vim.opt.sidescrolloff = 8
      vim.opt.wrap = false
      vim.opt.breakindent = true
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 400
      vim.opt.mouse = "a"

      -- Indentation
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
      vim.opt.smartindent = true

      -- Search
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.incsearch = true
      vim.opt.hlsearch = true

      -- Editing
      vim.opt.undofile = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.confirm = true

      -- Two-space indentation for common config and web files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "nix", "lua", "json", "yaml",
          "html", "css", "javascript",
          "javascriptreact", "typescript",
          "typescriptreact",
        },
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
        end,
      })

      -- Theme
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")

      -- Small, focused editing enhancements
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.indentscope").setup({
        symbol = "│",
        options = {
          try_as_border = true,
        },
      })
      require("mini.statusline").setup()

      -- Save and quit
      vim.keymap.set("n", "<leader>w", "<cmd>write<cr>",
        { desc = "Save file" })
      vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>",
        { desc = "Quit window" })
      vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>",
        { desc = "Quit Neovim" })

      -- Buffer navigation
      vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>",
        { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>",
        { desc = "Previous buffer" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>",
        { desc = "Close buffer" })

      -- Window navigation
      vim.keymap.set("n", "<C-h>", "<C-w>h")
      vim.keymap.set("n", "<C-j>", "<C-w>j")
      vim.keymap.set("n", "<C-k>", "<C-w>k")
      vim.keymap.set("n", "<C-l>", "<C-w>l")

      -- Clear search highlighting
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>",
        { desc = "Clear search highlight" })
    '';
  };
}
