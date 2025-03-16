-- LSP configuration for TS based on VS Code settings
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local vscode = require("modules.vscode")
      local vscode_settings = vscode.find_vscode_settings()

      if not vscode_settings then
        return
      end

      if not vscode.have_certain_lsp_settings(vscode_settings, "typescript") then
        return
      end

      -- Initialize vtsls server settings if not present
      opts.servers = opts.servers or {}
      opts.servers.vtsls = opts.servers.vtsls or {}
      opts.servers.vtsls.settings = opts.servers.vtsls.settings or {}
      opts.servers.vtsls.settings.typescript = opts.servers.vtsls.settings.typescript or {}

      -- Process all typescript.* settings and apply them with proper nesting
      vscode.process_settings_with_prefix("typescript", opts.servers.vtsls.settings.typescript, vscode_settings)
    end,
  },
}
