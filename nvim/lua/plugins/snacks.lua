return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          ---@type snacks.picker.explorer.Config
          explorer = {
            hidden = true,
          },
          ---@type snacks.picker.files.config
          files = {
            hidden = true,
          },
          ---@type snacks.picker.grep.config
          grep = {
            hidden = true,
          },
        },
      },
    },
  },
}
