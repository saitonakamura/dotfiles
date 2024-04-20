return {
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
	"vim-scripts/ReplaceWithRegister",
	-- comments
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"terrortylor/nvim-comment",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			hook = function()
				require("ts_context_commentstring.internal").update_commentstring()
			end,
		},
		config = function(_, opts)
			require("nvim_comment").setup(opts)
		end,
	},

	-- Treesitter is a new parser generator tool that we can
	-- use in Neovim to power faster and more accurate
	-- syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Deccrement selection", mode = "x" },
		},
		--@type TSConfig
		opts = {
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
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		--@param opts TSConfig
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- Show context of the current function
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "VeryLazy" },
		enabled = true,
		opts = { mode = "cursor", max_lines = 3 },
		-- keys = {
		--   {
		--     "<leader>ut",
		--     function()
		--       local tsc = require("treesitter-context")
		--       tsc.toggle()
		--       if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
		--         LazyVim.info("Enabled Treesitter Context", { title = "Option" })
		--       else
		--         LazyVim.warn("Disabled Treesitter Context", { title = "Option" })
		--       end
		--     end,
		--     desc = "Toggle Treesitter Context",
		--   },
		-- },
	},

	-- Fuzzy finder
	-- TODO implement this
	-- The default key bindings to find files will use Telescope's
	-- `find_files` or `git_files` depending on whether the
	-- directory is a git repo.
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = vim.fn.executable("make") == 1,
				-- config = function()
				-- 	require("lazy").on_load("telescope.nvim", function()
				-- 		require("telescope").load_extension("fzf")
				-- 	end)
				-- end,
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffer",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Find help tag",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").treesitter()
				end,
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Find command",
			},
		},
		config = function(_, opts)
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
		end,
	},
	-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

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

	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{ "<leader>fp", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
			-- TODO Understand if I need this?
			-- {
			-- 	"<leader>ge",
			-- 	function()
			-- 		require("neo-tree.command").execute({ source = "git_status", toggle = true })
			-- 	end,
			-- 	desc = "Git Explorer",
			-- },
			-- {
			--   "<leader>be",
			--   function()
			--     require("neo-tree.command").execute({ source = "buffers", toggle = true })
			--   end,
			--   desc = "Buffer Explorer",
			-- },
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.uv.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					-- ["O"] = {
					-- 	function(state)
					-- 		require("lazy.util").open(state.tree:get_node().path, { system = true })
					-- 	end,
					-- 	desc = "Open with System Application",
				},
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
		config = function(_, opts)
			-- local function on_move(data)
			--   LazyVim.lsp.on_rename(data.source, data.destination)
			-- end

			-- local events = require("neo-tree.events")
			-- opts.event_handlers = opts.event_handlers or {}
			-- vim.list_extend(opts.event_handlers, {
			--   { event = events.FILE_MOVED, handler = on_move },
			--   { event = events.FILE_RENAMED, handler = on_move },
			-- })
			require("neo-tree").setup(opts)
			-- vim.api.nvim_create_autocmd("TermClose", {
			--   pattern = "*lazygit",
			--   callback = function()
			--     if package.loaded["neo-tree.sources.git_status"] then
			--       require("neo-tree.sources.git_status").refresh()
			--     end
			--   end,
			-- })
		end,
		-- config = function()
		-- 	require("neo-tree").setup()
		-- 	-- vim.keymap.set('n', '<leader>fp', ':Neotree<CR>', {})
		-- end,
	},

	-- colorscheme
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

	-- lsp
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		--@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			---@type vim.diagnostic.Opts
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
				-- signs = {
				--   text = {
				--     [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
				--     [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
				--     [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
				--     [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
				--   },
				-- },
			},
			-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints.
			inlay_hints = {
				enabled = false,
			},
			-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the code lenses.
			codelens = {
				enabled = false,
			},
			-- add any global capabilities here
			capabilities = {},
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			-- format = {
			-- 	formatting_options = nil,
			-- 	timeout_ms = nil,
			-- },
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					-- Use this to add any additional keymaps
					-- for specific lsp servers
					---@type LazyKeysSpec[]
					-- keys = {},
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			local servers = opts.servers

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					-- if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					-- 	setup(server)
					-- elseif server_opts.enabled ~= false then
					if server_opts.enabled ~= false then
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities(),
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })

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

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

					vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
					-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set('n', '<space>wl', function()
					--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					-- vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
					-- vim.keymap.set("n", "<leader>ar", vim.lsp.buf.rename, opts)
					-- vim.keymap.set({ "n", "v" }, "<leader>am", vim.lsp.buf.code_action, opts)
					-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					-- vim.keymap.set('n', '<leader>af', function()
					--   vim.lsp.buf.format { async = true }
					-- end, opts)
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		lazy = true,
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = {
			ensure_installed = { "lua_ls", "cssls", "eslint", "html", "jsonls", "tsserver" },
		},
	},

	"mhartington/formatter.nvim",

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		-- Not all LSP servers add brackets when completing a function.
		-- To better deal with this, LazyVim adds a custom option to cmp,
		-- that you can configure. For example:
		--
		-- ```lua
		-- opts = {
		--   auto_brackets = { "python" }
		-- }
		-- ```

		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			return {
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				-- formatting = {
				-- 	format = function(_, item)
				-- 		-- local icons = require("lazyvim.config").icons.kinds
				-- 		-- if icons[item.kind] then
				-- 		-- 	item.kind = icons[item.kind] .. item.kind
				-- 		-- end
				-- 		return item
				-- 	end,
				-- },
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,
		---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
		config = function(_, opts)
			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end
			local cmp = require("cmp")
			local Kind = cmp.lsp.CompletionItemKind
			cmp.setup(opts)
			cmp.event:on("confirm_done", function(event)
				if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
					return
				end
				local entry = event.entry
				local item = entry:get_completion_item()
				if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
					local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
					vim.api.nvim_feedkeys(keys, "i", true)
				end
			end)
		end,
		-- config = function()
		-- 	-- local cmp = require'cmp'
		-- 	--
		-- 	-- cmp.setup({
		-- 	--   sources = cmp.config.sources({
		-- 	--     --{ name = 'copilot', group_index = 2 },
		-- 	--     { name = 'nvim_lsp', group_index = 2 }
		-- 	--   })
		-- 	-- })
		-- 	--
		-- 	-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- end,
	},

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		-- build = (not LazyVim.is_win())
		--     and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
		--   or nil,
		version = "v2.*",
		build = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"nvim-cmp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
				},
				opts = function(_, opts)
					opts.snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					}
					table.insert(opts.sources, { name = "luasnip" })
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
	},
}
