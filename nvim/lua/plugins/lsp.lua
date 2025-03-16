return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     -- inlay_hints = { enabled = false },
  --   },
  -- },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "csv",
        "dockerfile",
        "go",
        "helm",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "php_only",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      local vscode = require("modules.vscode")
      local vscode_settings = vscode.find_vscode_settings()

      opts.ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      }

      if not vscode_settings then
        return
      end

      if vscode.have_yaml_stuff(vscode_settings) then
        table.insert(opts.ensure_installed, "yamlls")
      end
    end,
  },
}
