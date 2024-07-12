return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
    opts.filesystem.filtered_items.hide_dotfiles = false
    opts.filesystem.filtered_items.hide_by_name = { "node_modules", ".git" }
    opts.filesystem.filtered_items.never_show = { ".DS_Store", "thumbs.db", "desktop.ini" }

    opts.window.mappings["Yf"] = opts.window.mappings["Y"]
    opts.window.mappings["Y"] = nil
    opts.window.mappings["Yr"] = {
      function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- local root = require("lazyvim.util").root.get()
        local relative_path = vim.fn.fnamemodify(path, ":.")
        -- if vim.startswith(relative_path, root) then
        --   relative_path = vim.fn.fnamemodify(relative_path, ":s?" .. root .. "/??")
        -- end
        vim.fn.setreg("+", relative_path, "c")
      end,
      desc = "Copy Root relative path to Clipboard",
    }
  end,
}
