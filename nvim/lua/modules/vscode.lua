local M = {}

-- Cache structure with cwd as key
-- Each entry contains:
--   path: path to settings.json
--   settings: parsed settings content
--   last_modified: last modified time of the file
--   timestamp: when cache entry was created/updated
local cache = {}

-- Cache expiration time in seconds
local CACHE_EXPIRY = 30

-- Map of VSCode formatter IDs to conform formatter names
M.formatter_map = {
  ["esbenp.prettier-vscode"] = "prettier",
  ["dbaeumer.vscode-eslint"] = "eslint_d",
  ["vscode.json-language-features"] = "fixjson",
  ["ms-python.python"] = "black",
  ["ms-python.black-formatter"] = "black",
  ["rust-lang.rust-analyzer"] = "rustfmt",
  ["redhat.vscode-yaml"] = "yamlfmt",
  ["golang.go"] = "gofmt",
  ["tamasfe.even-better-toml"] = "taplo",
  ["Vue.volar"] = "prettier",
  ["svelte.svelte-vscode"] = "prettier",
  ["stylelint.vscode-stylelint"] = "stylelint",
  ["sumneko.lua"] = "stylua",
  ["zigtools.zls"] = "zigfmt",
  ["joshbolduc.tailwindcss-language-server"] = "prettier",
  -- Add more mappings as needed
}

-- Helper function to check if a file exists and get its modified time
local function file_info(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    local attrs = vim.uv.fs_stat(path)
    return true, attrs and attrs.mtime.sec or nil
  end
  return false, nil
end

-- Helper function to combine paths
local function path_join(...)
  local sep = package.config:sub(1, 1) -- Path separator (/ on Unix, \ on Windows)
  local path = table.concat({ ... }, sep)
  return path
end

-- Helper function to get parent directory
local function get_parent_dir(path)
  local sep = package.config:sub(1, 1)
  return path:match("(.*)" .. sep .. ".*$") or ""
end

-- Function to read and parse a settings.json file
local function read_settings(file_path)
  local file = io.open(file_path, "r")
  if not file then
    return nil
  end

  local content = file:read("*all")
  file:close()

  local success, settings = pcall(function()
    return vim.json.decode(content)
  end)

  if success then
    return settings
  else
    vim.notify("Error parsing " .. file_path .. ": " .. tostring(settings), vim.log.levels.WARN)
    return nil
  end
end

-- Function to find .vscode/settings.json up the directory tree
function M.find_vscode_settings()
  local cwd = vim.fn.getcwd()
  local current_time = os.time()

  -- Check if we have a valid cached entry for this cwd
  if cache[cwd] then
    local cached = cache[cwd]

    -- Check if cache is still valid (not expired and file hasn't changed)
    if (current_time - cached.timestamp) < CACHE_EXPIRY then
      local exists, mtime = file_info(cached.path)
      if exists and mtime == cached.last_modified then
        return cached.settings
      end
    end
  end

  -- Cache is invalid or doesn't exist, search for settings.json
  local current_dir = cwd
  local root_reached = false
  local previous_dir = ""

  while not root_reached do
    -- Check for .vscode directory
    local vscode_dir = path_join(current_dir, ".vscode")
    local settings_path = path_join(vscode_dir, "settings.json")

    local exists, mtime = file_info(settings_path)
    if exists then
      -- Found the settings.json, read and parse it
      local settings = read_settings(settings_path)

      if settings then
        -- Update cache
        cache[cwd] = {
          path = settings_path,
          settings = settings,
          last_modified = mtime,
          timestamp = current_time,
        }

        return settings
      end
    end

    -- Move up to parent directory
    local parent_dir = get_parent_dir(current_dir)

    -- Check if we've reached the root
    if parent_dir == current_dir or parent_dir == previous_dir or parent_dir == "" then
      root_reached = true
    else
      previous_dir = current_dir
      current_dir = parent_dir
    end
  end

  -- No settings file found, cache the negative result too
  --cache[cwd] = {
  --  path = nil,
  --  settings = nil,
  --last_modified = nil,
  -- timestamp = current_time,
  --}

  -- No settings file found
  return nil
end

-- Function to clear the cache
function M.clear_cache()
  cache = {}
  vim.notify("VS Code settings cache cleared", vim.log.levels.INFO)
end

function M.have_certain_lsp_settings(vscode_settings, lsp_name)
  for key, _ in pairs(vscode_settings) do
    if key:match("^" .. lsp_name .. "%.") then
      return true
    end
  end
  return false
end

-- Helper function to set deeply nested fields using dot notation
local function set_nested_field(target, path, value)
  local parts = {}
  for part in string.gmatch(path, "[^%.]+") do
    table.insert(parts, part)
  end

  local current = target
  for i = 1, #parts - 1 do
    local key = parts[i]
    current[key] = current[key] or {}
    current = current[key]
  end

  current[parts[#parts]] = value
end

-- Helper function to process VS Code settings with prefix and apply to target
function M.process_settings_with_prefix(prefix, target, vscode_settings)
  local prefix_pattern = "^" .. prefix .. "%."

  for key, value in pairs(vscode_settings) do
    if type(key) == "string" and key:match(prefix_pattern) then
      local nested_key = key:gsub(prefix_pattern, "")
      set_nested_field(target, nested_key, value)
    end
  end
end

-- Invalidate cache when directory changes
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local cwd = vim.fn.getcwd()
    cache[cwd] = nil
  end,
})

return M
