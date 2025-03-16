function hasNoDots(path)
  -- Matches any occurrence of . or .. in the path
  return not path:match("%.%.?")
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function(args)
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      if hasNoDots(arg) then
        local path = vim.uv.cwd() .. "/" .. arg
        vim.api.nvim_set_current_dir(path)
      end
    end
  end,
})

local vscode = require("modules.vscode")

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    local settings = vscode.find_vscode_settings()
    -- Create a map of filetype-specific format-on-save settings
    local ft_format_map = {}
    for key, value in pairs(settings) do
      if type(key) == "string" and key:match("^%[.*%]$") then
        -- Extract the filetype from the key (e.g., "[typescript]" -> "typescript")
        local ft = key:match("%[(.*)%]")

        -- Check if there's a format-on-save setting for this filetype
        if ft and type(value) == "table" and value["editor.formatOnSave"] ~= nil then
          ft_format_map[ft] = value["editor.formatOnSave"]
        end
      end
    end
    -- vim.b.autoformat = false
    local ft = vim.bo.filetype
    -- Check if we have a specific setting for this filetype
    if ft_format_map[ft] ~= nil then
      vim.b.autoformat = ft_format_map[ft]
      if ft_format_map[ft] then
        vim.notify("Format on save enabled for " .. ft, vim.log.levels.INFO)
      else
        vim.notify("Format on save disabled for " .. ft, vim.log.levels.INFO)
      end
    else
      -- Fall back to global setting
      vim.b.autoformat = nil
    end
  end,
})

vim.notify("Loaded format-on-save configuration from VS Code settings", vim.log.levels.INFO)
