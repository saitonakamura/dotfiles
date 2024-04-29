-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- default config for your plugin
local defaults = {
  autoformat = false,
  by_filetype = {},
}

local function setup_buffer()
  -- local buf = vim.api.nvim_get_current_buf()
  -- print(buf)
  local my_settings = require("neoconf").get("myplugin", defaults)

  -- if not my_settings.autoformat then
  local ft = vim.bo.filetype
  local filetype_settings = my_settings.by_filetype[ft] or { autoformat = nil }
  if filetype_settings.autoformat ~= nil then
    local buf = vim.api.nvim_get_current_buf()
    local baf = vim.b[buf].autoformat
    if baf ~= filetype_settings.autoformat then
      vim.b.autoformat = filetype_settings.autoformat
    end
  else
    vim.b.autoformat = nil
  end
end

local formatbyfiletype = vim.api.nvim_create_augroup("formatbyfiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  group = formatbyfiletype,
  callback = function()
    setup_buffer()
  end,
})

local function setup_global()
  local my_settings = require("neoconf").get("myplugin", defaults)
  local enabled = vim.g.autoformat
  if my_settings.autoformat ~= enabled then
    vim.g.autoformat = my_settings.autoformat
  end
end

-- register your settings schema with Neodev, so auto-completion will work in the json files
require("neoconf.plugins").register({
  name = "myplugin",
  setup = function()
    setup_global()
  end,
  on_update = function(settings)
    setup_global()
  end,
  on_schema = function(schema)
    -- this call will create a json schema based on the lua types of your default settings
    schema:import("myplugin", defaults)
    -- Optionally update some of the json schema
    schema:set("myplugin.by_filetype", {
      description = "Granular settings by filetype",
      type = "object",
      propertyNames = {
        pattern = "^.*$",
      },
      properties = {
        type = "object",
        properties = {
          filetype = {
            type = "string",
            description = "The filetype to apply the settings to",
          },
          autoformat = {
            type = "boolean",
            description = "Enable autoformat for this filetype",
          },
        },
      },
    })
  end,
})
