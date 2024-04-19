-- inspiration https://github.com/jdhao/nvim-config/blob/master/lua/mappings.lua

local keymap = vim.keymap

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")