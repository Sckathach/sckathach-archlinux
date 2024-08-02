return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "html-lsp", "css-lsp" , "prettier", "pyright",
        "mypy", "black", "typescript-language-server",
        "tailwindcss-language-server", "eslint-lsp", "clangd", "clang-format",
        "ruff", "debugpy"
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false
  },
}
