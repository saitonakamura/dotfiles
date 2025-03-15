-- return {}
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ------@type snacks.image.Config
      ---image = {
      ---  enabled = true,
      ---},
      -- explorer = {
      --   -- your explorer configuration comes here
      --   -- or leave it empty to use the default settings
      --   -- refer to the configuration section below
      -- },
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
  -- {
  --   "s1n7ax/nvim-window-picker",
  --   opts = {
  --     hint = "floating-big-letter",
  --   },
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     filesystem = {
  --       filtered_items = {
  --         hide_dotfiles = false,
  --         hide_by_name = { "node_modules", ".git" },
  --         never_show = { ".DS_Store", "thumbs.db", "desktop.ini" },
  --       },
  --     },
  --     window = {
  --       mappings = {
  --         ["Y"] = "none",
  --         ["Yf"] = {
  --           function(state)
  --             local node = state.tree:get_node()
  --             local path = node:get_id()
  --             vim.fn.setreg("+", path, "c")
  --           end,
  --           desc = "Copy Path to Clipboard",
  --         },
  --         ["Yr"] = {
  --           function(state)
  --             local node = state.tree:get_node()
  --             local path = node:get_id()
  --             local relative_path = vim.fn.fnamemodify(path, ":.")
  --             vim.fn.setreg("+", relative_path, "c")
  --           end,
  --           desc = "Copy Root relative path to Clipboard",
  --         },
  --         ["W"] = "open_with_window_picker",
  --         ["w"] = "none",
  --         ["ws"] = "open_split",
  --         ["wv"] = "open_vsplit",
  --         ["s"] = "none",
  --         ["S"] = "none",
  --         ["sg"] = {
  --           function(state)
  --             local node = state.tree:get_node()
  --             local path = node:get_id()
  --             if (node.type == "directory") then
  --               path = path .. "/"
  --             end
  --             local dir = vim.fn.fnamemodify(path, ":h")
  --             local relative_path = vim.fn.fnamemodify(dir, ":.")
  --             LazyVim.pick("live_grep", { cwd = dir, prompt_title = "Live Grep " .. relative_path })()
  --           end,
  --           desc = "Grep focused dir",
  --         },
  --       },
  --     },
  --   },
  --   -- opts = function(_, opts)
  --   --   opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
  --   --   opts.filesystem.filtered_items.hide_dotfiles = false
  --   --   opts.filesystem.filtered_items.hide_by_name = { "node_modules", ".git" }
  --   --   opts.filesystem.filtered_items.never_show = { ".DS_Store", "thumbs.db", "desktop.ini" }
  --   --
  --   --   opts.window.mappings["Yf"] = opts.window.mappings["Y"]
  --   --   opts.window.mappings["Y"] = nil
  --   --   opts.window.mappings["Yr"] = {
  --   --     function(state)
  --   --       local node = state.tree:get_node()
  --   --       local path = node:get_id()
  --   --       -- local root = require("lazyvim.util").root.get()
  --   --       local relative_path = vim.fn.fnamemodify(path, ":.")
  --   --       -- if vim.startswith(relative_path, root) then
  --   --       --   relative_path = vim.fn.fnamemodify(relative_path, ":s?" .. root .. "/??")
  --   --       -- end
  --   --       vim.fn.setreg("+", relative_path, "c")
  --   --     end,
  --   --     desc = "Copy Root relative path to Clipboard",
  --   --   }
  --   --
  --   --   opts.window.mappings["W"] = opts.window.mappings["w"]
  --   --   opts.window.mappings["w"] = nil
  --   --
  --   --   opts.window.mappings["ws"] = opts.window.mappings["s"]
  --   --   opts.window.mappings["s"] = nil
  --   --
  --   --   opts.window.mappings["wv"] = opts.window.mappings["S"]
  --   --   opts.window.mappings["S"] = nil
  --   --
  --   --   opts.window.mappings["sg"] = {
  --   --     function (state)
  --   --       local node = state.tree:get_node()
  --   --       local path = node:get_id()
  --   --       local dir = vim.fn.fnamemodify(path, ":h")
  --   --       LazyVim.pick("live_grep", { cwd = dir })
  --   --     end,
  --   --     desc = "Grep current dir",
  --   --   }
  --   -- end,
  -- },
}
