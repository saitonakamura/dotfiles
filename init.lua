if vim.g.neovide then
  vim.o.guifont = 'Cascadia Code PL:h14'
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require "paq" {
  'savq/paq-nvim',
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  'kylechui/nvim-surround',
  'neovim/nvim-lspconfig',
  'tjdevries/colorbuddy.vim',
  'Th3Whit3Wolf/onebuddy',
  'f-person/auto-dark-mode.nvim',
}


vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
local colorbuddy = require('colorbuddy')
colorbuddy.colorscheme('onebuddy')


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<Leader>w', ':write<CR>')


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 30000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
    colorbuddy.colorscheme('onebuddy')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
    colorbuddy.colorscheme('onebuddy')
	end,
})

require("nvim-surround").setup()


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "css", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "javascript", "json", "lua", "make", "python", "tsx", "typescript", "yaml"  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats.size > max_filesize then
        return true
      end
    end,
  }
}
--if (vim.bo.filetype == 'lua') then
--  vim.bo.expandtab = true
--  vim.bo.shiftwidth = 2
--end

