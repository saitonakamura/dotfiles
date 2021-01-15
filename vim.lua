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

local on_attach = function(client, bufnr, ...)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  require'completion'.on_attach(client, bufnr, ...)
end

-- require'lspconfig'.intelephense.setup{}

local lspconfig = require'lspconfig'

local pid = vim.fn.getpid()
local omnisharp_bin = "omnisharp-language-server"

lspconfig.vimls.setup{ on_attach = on_attach }
lspconfig.tsserver.setup{ on_attach = on_attach }
lspconfig.jsonls.setup{ on_attach = on_attach }
lspconfig.cssls.setup{ on_attach = on_attach }
lspconfig.bashls.setup{ on_attach = on_attach }

lspconfig.omnisharp.setup{
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  on_attach = on_attach,
}

local sumneko_root_path = "/home/saito/.local/share/lua-language-server"
local sumneko_bin = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup{
  cmd = { sumneko_bin, "-E", sumneko_root_path.."/main.lua"},
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
