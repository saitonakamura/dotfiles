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
      },
    },
  },
}
