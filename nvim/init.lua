vim.loader.enable()

require('globals')
require('options')
require('autocommands')
require('mappings')

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
	"vim-scripts/ReplaceWithRegister",
	{
		"terrortylor/nvim-comment",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			-- require'nvim_comment'.setup()

			require("nvim_comment").setup({
				hook = function()
					require("ts_context_commentstring.internal").update_commentstring()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"css",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"html",
					"javascript",
					"json",
					"lua",
					"make",
					"python",
					"tsx",
					"typescript",
					"yaml",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local _ = lang
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
			})
		end,
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
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
			{ "<leader>fp", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("neo-tree").setup()
			-- vim.keymap.set('n', '<leader>fp', ':Neotree<CR>', {})
		end,
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
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"mhartington/formatter.nvim",
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
})

if vim.g.neovide then
	vim.o.guifont = "Cascadia Code PL:h14"
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



require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")

local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", telescope_builtin.treesitter, {})
vim.keymap.set("n", "<leader>fc", telescope_builtin.commands, {})


require("mason").setup()
require("mason-lspconfig").setup({
	efnsure_installed = { "lua_ls", "cssls", "eslint", "html", "jsonls", "tsserver" },
})

local lsp_config = require("lspconfig")
lsp_config.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = { globals = { "vim" } },
		},
	},
})
lsp_config.tsserver.setup({})

vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>eq", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>ew", vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- -- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		--
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wl', function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>am', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
		-- vim.keymap.set('n', '<leader>af', function()
		--   vim.lsp.buf.format { async = true }
		-- end, opts)
	end,
})

-- local util = require("formatter.util")

require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
    javascript = { require('formatter.filetypes.javascript').prettier },
    javascriptreact = { require('formatter.filetypes.javascriptreact').prettier },
    typescript = { require('formatter.filetypes.typescript').prettier },
    typescriptreact = { require('formatter.filetypes.typescriptreact').prettier },
	},
})

vim.keymap.set("n", "<leader>af", ":Format<CR>")

-- vim.keymap.set('n', '<leader>fp', ':Neotree<CR>', {})
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
