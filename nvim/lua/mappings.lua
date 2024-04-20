-- inspiration https://github.com/jdhao/nvim-config/blob/master/lua/mappings.lua

local keymap = vim.keymap
local uv = vim.loop

-- Shortcut for save
keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })

-- not sure if it's still needed
-- keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true,  })

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
	silent = true,
	desc = "open init.lua",
})

keymap.set("n", "<leader>sv", function()
	vim.cmd([[
      update %
      source %
    ]])
	vim.notify("Nvim config successfully reloaded with current file!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
	silent = true,
	desc = "reload config with current file",
})

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
	expr = true,
	desc = "reselect last pasted area",
})

-- Always use very magic mode for searching
keymap.set("n", "/", [[/\v]])

-- Remove search highlight
keymap.set("n", "<leader>/", ":nohlsearch<CR>")

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Find the cursor
keymap.set("n", "<leader>cb", function()
	local cnt = 0
	local blink_times = 7
	local timer = uv.new_timer()

	timer:start(
		0,
		100,
		vim.schedule_wrap(function()
			vim.cmd([[
      set cursorcolumn!
      set cursorline!
    ]])

			if cnt == blink_times then
				timer:close()
			end

			cnt = cnt + 1
		end)
	)
end)
