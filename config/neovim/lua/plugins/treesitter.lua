return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Prevent compiling dynamic parsers from the web; use Mason or system packages
      auto_install = false,
      ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    },
  },
}
