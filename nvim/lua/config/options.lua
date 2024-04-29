-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
  vim.g.neovide_input_ime = false
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_theme = "auto"
  -- vim.o.guifont = { "CaskadyiaCove Nerd Font", ":h12" }
  -- vim.o.guifont = "CaskadyiaCove Nerd Font:h12"
  -- vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  -- https://github.com/neovide/neovide/issues/1553
  vim.opt.title = true
  --https://github.com/neovide/neovide/issues/2330
  vim.defer_fn(function()
    vim.cmd("NeovideFocus")
  end, 25)
end

vim.g.root_spec = { "lsp", { ".git", "lua", "node_modules" }, "cwd" }
vim.g.autoformat = false
