return {
  -- https://github.com/gbprod/substitute.nvim?tab=readme-ov-file
  {
    "gbprod/substitute.nvim",
    opts = {},
    -- opts = {
    --   -- prefix = "gr",
    -- },
    init = function()
      -- remap as https://github.com/vim-scripts/ReplaceWithRegister
      vim.keymap.set("n", "gp", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "gpp", require("substitute").line, { noremap = true })
      -- vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "gp", require("substitute").visual, { noremap = true })
    end,
  },
}
