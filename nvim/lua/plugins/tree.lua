return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    -- opts.filesystem.filtered_items.hide_dotfiles = false
    opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
    opts.filesystem.filtered_items.hide_dotfiles = false
    opts.filesystem.filtered_items.hide_by_name = { "node_modules", ".git" }
    opts.filesystem.filtered_items.never_show = { ".DS_Store", "thumbs.db", "desktop.ini" }
  end,
}
