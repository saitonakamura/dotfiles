if vim.g.neovide then
  vim.o.guifont = 'Cascadia Code PL:h14'
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require "paq" {
  'savq/paq-nvim',

  'nvim-lua/plenary.nvim',

  { 'nvim-telescope/telescope.nvim', branch = '0.1.3' },
  
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  'JoosepAlviste/nvim-ts-context-commentstring',
  'terrortylor/nvim-comment',
  'kylechui/nvim-surround',
  'neovim/nvim-lspconfig',

  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  'zbirenbaum/copilot.lua',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',

  'zbirenbaum/copilot-cmp',

  'tjdevries/colorbuddy.vim',
  'Th3Whit3Wolf/onebuddy',
  'f-person/auto-dark-mode.nvim',
}


vim.opt.number = true
--vim.opt.mouse = 'a'
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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
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

require'nvim_comment'.setup {
  hook = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
}

local cmp = require'cmp'

cmp.setup({
  sources = cmp.config.sources({
    --{ name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()


--require('copilot').setup({})
--vim.api.nvim_create_user_command('CopilotSetup',
--  function()
--    require('copilot').setup({})
--  end,
--  {}
--)
--if (vim.bo.filetype == 'lua') then
--  vim.bo.expandtab = true
--  vim.bo.shiftwidth = 2
--end

require'telescope'.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require'telescope'.load_extension('fzf')

local telescope_builtin = require'telescope.builtin'

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', telescope_builtin.treesitter, {})
vim.keymap.set('n', '<leader>fc', telescope_builtin.commands, {})

