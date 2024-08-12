-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
  vim.g.neovide_input_ime = false
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_theme = "auto"
  -- https://github.com/neovide/neovide/issues/1553
  vim.opt.title = true
  --https://github.com/neovide/neovide/issues/2330
  vim.defer_fn(function()
    vim.cmd("NeovideFocus")
  end, 25)
-- end
else
  -- if vim.fn.has("gui_running") == 0 then
  vim.cmd([[
    highlight Cursor guifg=#e1e2e7 guibg=#3760bf
  ]])
  vim.cmd([[
    set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50
  ]])
end

vim.o.background = "light"
vim.g.root_spec = { "lsp", { ".git", "lua", "node_modules" }, "cwd" }
vim.g.autoformat = false
