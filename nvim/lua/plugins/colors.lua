return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      on_colors = function(colors)
        if vim.o.background == "light" then
          colors.bg = "#fafafa"
        end
      end,
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        -- vim.cmd("colorscheme tokyonight")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        -- vim.cmd("colorscheme doom-one")
        -- vim.cmd("colorscheme tokyonight")
      end,
    },
  },
}
