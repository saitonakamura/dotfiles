local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 and vim.fn.filereadable("/proc/version") then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

vim.o.mouse = 'a'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.termguicolors = true
vim.opt.undofile = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.lsp.set_log_level("debug")

local fd_cli = "fd"

if system_name == "Linux" then
  fd_cli = "fdfind"
end

-- require('telescope').setup {
--   pickers = {
--     find_files = {
--       find_command = {
--         fd_cli, "--hidden", "--type", "f"
--       }
--     }
--   }
-- }

vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>E', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>vs', require('telescope.builtin').git_branches)
-- vim.keymap.set('n', '<leader>f', vim)

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr, ...)
  -- vim.api.
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- require'completion'.on_attach(client, bufnr, ...)

  local opts = { buffer = bufnr }
  vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', '<leader>gs', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>ps', require('telescope.builtin').lsp_document_symbols, opts)
  vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>am', vim.lsp.buf.code_action, opts)
  -- vim.keymap.set('n', '<leader>af', vim.lsp.buf.formatting, {})
  -- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- require'lspconfig'.intelephense.setup{}

local lspconfig = require'lspconfig'

local pid = vim.fn.getpid()
local omnisharp_bin = "omnisharp-language-server"

-- lspconfig.vimls.setup{ on_attach = on_attach }
lspconfig.tsserver.setup{ on_attach = on_attach, capabilities = capabilities }
lspconfig.eslint.setup{ on_attach = on_attach, capabilities = capabilities }
lspconfig.jsonls.setup{ on_attach = on_attach, capabilities = capabilities }
lspconfig.html.setup{ on_attach = on_attach, capabilities = capabilities }
lspconfig.cssls.setup{ on_attach = on_attach, capabilities = capabilities }
-- lspconfig.bashls.setup{ on_attach = on_attach }

-- lspconfig.omnisharp.setup{
--   cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
--   on_attach = on_attach,
-- }

local sumneko_root_path = "/home/saito/.local/share/lua-language-server"
local sumneko_bin = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- lspconfig.sumneko_lua.setup{
--   cmd = { sumneko_bin, "-E", sumneko_root_path.."/main.lua"},
--   on_attach = on_attach,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = vim.split(package.path, ';'),
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--           [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--         },
--       },
--     },
--   },
-- }
local luasnip = require 'luasnip'
local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

