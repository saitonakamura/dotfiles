-- Module for loading markdown files from .github/prompts directory
local M = {}

-- Find the .github/prompts directory by traversing up the directory tree
local function find_prompts_dir()
  local path = vim.fn.getcwd()
  local previous_path = nil

  while path ~= previous_path do
    local prompts_path = path .. "/.github/prompts"
    if vim.fn.isdirectory(prompts_path) == 1 then
      return prompts_path
    end

    previous_path = path
    path = vim.fn.fnamemodify(path, ":h")
  end

  return nil
end

-- Read file content using io module
local function read_file(file_path)
  local file, err = io.open(file_path, "r")
  if not file then
    return nil, "Failed to open file: " .. (err or "unknown error")
  end

  local content = file:read("*a")
  file:close()

  return content
end

-- List all markdown files in the directory
local function list_md_files(dir_path)
  local files = {}
  local handle = io.popen("ls " .. dir_path .. "/*.prompt.md 2>/dev/null")

  if handle then
    for file in handle:lines() do
      table.insert(files, file)
    end
    handle:close()
  end

  return files
end

-- Get filename without extension
local function get_filename_without_extension(file_path)
  local filename = vim.fn.fnamemodify(file_path, ":t:r"):gsub("%.prompt$", "")
  return filename
end

-- Load all markdown files from .github/prompts directory
function M.load_prompts()
  local prompts = {}
  local prompts_dir = find_prompts_dir()

  if not prompts_dir then
    vim.notify("Could not find .github/prompts directory", vim.log.levels.WARN)
    return prompts
  end

  local md_files = list_md_files(prompts_dir)

  for _, file_path in ipairs(md_files) do
    local filename = get_filename_without_extension(file_path)
    local content, err = read_file(file_path)

    if content then
      prompts[filename] = content
    else
      vim.notify("Failed to read " .. file_path .. ": " .. (err or "unknown error"), vim.log.levels.ERROR)
    end
  end

  return prompts
end

-- Get a specific prompt by name
function M.get_prompt(name)
  local prompts = M.load_prompts()
  return prompts[name]
end

return M
