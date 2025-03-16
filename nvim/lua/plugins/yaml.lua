-- LSP configuration for YAML based on VS Code settings
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local vscode = require("modules.vscode")
      local vscode_settings = vscode.find_vscode_settings()

      if not vscode_settings then
        return
      end

      if not vscode.have_certain_lsp_settings(vscode_settings, "yaml") then
        return
      end

      -- Initialize YAML server settings if not present
      opts.servers = opts.servers or {}
      opts.servers.yamlls = opts.servers.yamlls or {}
      opts.servers.yamlls.settings = opts.servers.yamlls.settings or {}
      opts.servers.yamlls.settings.yaml = opts.servers.yamlls.settings.yaml or {}

      -- Process all yaml.* settings and apply them with proper nesting
      vscode.process_settings_with_prefix("yaml", opts.servers.yamlls.settings.yaml)

      local function mergeTables(table1, table2)
        local merged = {}
        table.move(table1, 1, #table1, 1, merged)
        table.move(table2, 1, #table2, #merged + 1, merged)
        return merged
      end

      -- schemas are a little bit tricky
      -- Schema configurations
      if vscode_settings["yaml.schemas"] then
        opts.servers.yamlls.on_new_config = function(new_config)
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())

          -- Merge VS Code schema settings with existing schemas
          for schema_url, glob_pattern in pairs(vscode_settings["yaml.schemas"]) do
            local glob_pattern_tbl = type(glob_pattern) == "string" and { glob_pattern } or glob_pattern

            if new_config.settings.yaml.schemas[schema_url] then
              new_config.settings.yaml.schemas[schema_url] =
                mergeTables(new_config.settings.yaml.schemas[schema_url], glob_pattern_tbl)
            else
              new_config.settings.yaml.schemas[schema_url] = glob_pattern_tbl
            end
          end
        end
      end
    end,
  },
}
