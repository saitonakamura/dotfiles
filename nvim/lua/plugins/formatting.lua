return {
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts ConformOpts
    opts = function(_, opts)
      local vscode = require("modules.vscode")
      local vscode_settings = vscode.find_vscode_settings()

      if not vscode_settings then
        return
      end

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for key, value in pairs(vscode_settings) do
        if type(key) == "string" and key:match("^%[.*%]$") then
          -- Extract the filetype from the key (e.g., "[typescript]" -> "typescript")
          local filetype = key:match("%[(.*)%]")

          if filetype and value["editor.defaultFormatter"] then
            local vscode_formatter = value["editor.defaultFormatter"]
            local conform_formatter = vscode.formatter_map[vscode_formatter]

            if conform_formatter then
              -- Set the formatter for this filetype
              opts.formatters_by_ft[filetype] = { conform_formatter }
              print("Configured " .. filetype .. " to use " .. conform_formatter)

              -- Configure formatter options if applicable
              -- configure_formatter_options(opts, conform_formatter, settings)
            end
          end
        end
      end
      -- opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- for _, ft in ipairs(supported) do
      --   opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
      --   table.insert(opts.formatters_by_ft[ft], "prettier")
      -- end
      --
      -- opts.formatters = opts.formatters or {}
      -- opts.formatters.prettier = {
      --   condition = function(_, ctx)
      --     return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
      --   end,
      -- }
    end,
  },
}
