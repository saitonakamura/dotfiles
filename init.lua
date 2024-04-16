local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup({
  -- 'tjdevries/colorbuddy.vim',
  -- {
  --   'Th3Whit3Wolf/onebuddy',
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'tjdevries/colorbuddy.vim' },
  --   config = function()
  --     local colorbuddy = require('colorbuddy')
  --     -- colorbuddy.colorscheme('onebuddy')
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { 
    'terrortylor/nvim-comment',
    event = 'VeryLazy',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      -- require'nvim_comment'.setup()

      require'nvim_comment'.setup {
        hook = function()
          require('ts_context_commentstring.internal').update_commentstring()
        end,
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
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
        },
        indent = { enable = true },  
      })
    end
  },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { '<leader>fp', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    config = function()
      require('neo-tree').setup()
      -- vim.keymap.set('n', '<leader>fp', ':Neotree<CR>', {})
    end
  },
  {
    "f-person/auto-dark-mode.nvim",
    -- event = 'VeryLazy',
    config = {
      update_interval = 30000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd([[colorscheme tokyonight]])
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd([[colorscheme tokyonight-day]])
      end,
    },
  },
  {
    'neovim/nvim-lspconfig',

  },
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      -- 'neovim/nvim-lspconfig',
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
-- local cmp = require'cmp'
-- 
-- cmp.setup({
--   sources = cmp.config.sources({
--     --{ name = 'copilot', group_index = 2 },
--     { name = 'nvim_lsp', group_index = 2 }
--   })
-- })
-- 
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    end,
  },
}, opts)

if vim.g.neovide then
  vim.o.guifont = 'Cascadia Code PL:h14'
end


-- require "paq" {
  -- 'savq/paq-nvim',
  --
  -- 'nvim-lua/plenary.nvim',
  -- 'terrortylor/nvim-comment',
  --
  -- { 'nvim-telescope/telescope.nvim', branch = '0.1.6', pin = true },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'CFLAGS=-march=native make' },
 
  -- { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  -- 'JoosepAlviste/nvim-ts-context-commentstring',
  -- 'kylechui/nvim-surround',
  -- 'neovim/nvim-lspconfig',
  --
  --
  -- 'zbirenbaum/copilot.lua',
  --
  -- 'hrsh7th/cmp-nvim-lsp',
  -- 'hrsh7th/nvim-cmp',
  --
  -- 'zbirenbaum/copilot-cmp',

  -- 'tjdevries/colorbuddy.vim',
  -- 'Th3Whit3Wolf/onebuddy',
  -- 'f-person/auto-dark-mode.nvim',
-- }


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

vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

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

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- 
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = { "css", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "javascript", "json", "lua", "make", "python", "tsx", "typescript", "yaml"  },
--   sync_install = false,
--   auto_install = true,
--   context_commentstring = {
--     enable = true,
--     enable_autocmd = false,
--   },
--   highlight = {
--     enable = true,
--     disable = function(lang, buf)
--       local max_filesize = 100 * 1024 -- 100 KB
--       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--       if ok and stats.size > max_filesize then
--         return true
--       end
--     end,
--   }
-- }
-- 
-- 
-- local cmp = require'cmp'
-- 
-- cmp.setup({
--   sources = cmp.config.sources({
--     --{ name = 'copilot', group_index = 2 },
--     { name = 'nvim_lsp', group_index = 2 }
--   })
-- })
-- 
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 
-- 
-- --require('copilot').setup({})
-- --vim.api.nvim_create_user_command('CopilotSetup',
-- --  function()
-- --    require('copilot').setup({})
-- --  end,
-- --  {}
-- --)
-- --if (vim.bo.filetype == 'lua') then
-- --  vim.bo.expandtab = true
-- --  vim.bo.shiftwidth = 2
-- --end
--
-- 
