local plugins = {
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "mypy",
        "ruff",
        "gopls",
        "clangd",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "fatih/vim-go",
    ft = { "go" },
    cmd = { "GoInstallBinaries" },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" }
  }
}

return plugins
