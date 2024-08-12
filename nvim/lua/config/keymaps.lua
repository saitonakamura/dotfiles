-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Function to change font size
local function change_font_size(delta)
  local font = vim.opt.guifont:get()[1]
  local font_name, size = font:match("(.+):h(%d+)")
  size = tonumber(size) + delta
  if size < 1 then
    size = 1
  end
  vim.opt.guifont = font_name .. ":h" .. size
end

-- Allow clipboard copy paste with cmd in neovide, otherwise pasting text to terminal or grep is a pain
if vim.g.neovide then
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-\\><C-n>pi", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

  -- Commands to increase and decrease font size
  vim.api.nvim_create_user_command("IncreaseFontSize", function()
    change_font_size(1)
  end, {})
  vim.api.nvim_create_user_command("DecreaseFontSize", function()
    change_font_size(-1)
  end, {})

  -- Key mappings for font size changes
  vim.keymap.set("n", "<D-=>", ":IncreaseFontSize<CR>", { silent = true })
  vim.keymap.set("n", "<D-->", ":DecreaseFontSize<CR>", { silent = true })
end

-- save file with cmd+s
vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
