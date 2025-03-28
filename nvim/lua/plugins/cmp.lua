return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              search_paths = {
                vim.fn.stdpath("config") .. "/snippets",
                vim.uv.cwd() .. "/.vscode/",
              },
            },
          },
        },
        default = function(_ctx)
          if vim.bo.filetype == "copilot-chat" then
            return { "lsp", "snippets", "buffer" }
          end

          return { "lsp", "path", "snippets", "buffer" }
        end,
      },
    },
  },
}
