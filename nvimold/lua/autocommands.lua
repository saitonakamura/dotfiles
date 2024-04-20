-- inspiration https://github.com/jdhao/nvim-config/blob/master/viml_conf/autocommands.vim

local api = vim.api

-- Disable relative numbers when vim is not focused,
-- makes it easier to speak in absolute numbers when using other apps and in insert mode
local numbertoggle = api.nvim_create_augroup("numbertoggle", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	pattern = "*",
	group = numbertoggle,
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = true
		end
	end,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	pattern = "*",
	group = numbertoggle,
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = false
		end
	end,
})

-- hightlight yanked content
local highlight_group = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 250 })
	end,
	group = highlight_group,
	pattern = "*",
})

-- ref: https://vi.stackexchange.com/a/169/15292
-- local large_file = api.nvim_create_augroup("LargeFile", { clear = true })
-- api.nvim_create_autocmd("BufReadPre", {
-- 	pattern = "*",
-- 	group = largefile,
-- 	callback = function()
-- 		local large = 10485760 -- 10MB
-- 		-- TODO complete
-- 		--if getfsize(f) > g:large_file || getfsize(f) == -2
-- 		--   set eventignore+=all
-- 		--   " turning off relative number helps a lot
-- 		--   set norelativenumber
-- 		--   setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1
-- 		-- else
-- 		--   set eventignore-=all relativenumber
-- 		-- endif
-- 	end,
-- })

-- Display a message when the current file is not in utf-8 format.
-- Note that we need to use `unsilent` command here because of this issue:
-- https://github.com/vim/vim/issues/4379
api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*",
  group = api.nvim_create_augroup("non_utf8_file", { clear = true }),
  callback = function()
    if vim.bo.fileencoding ~= "utf-8" then
      vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
    end
  end,
})

-- TODO add Neotree load or set autocommand on neotree load
-- local function open_nvim_tree(data)
--   -- check if buffer is a directory
--   local directory = vim.fn.isdirectory(data.file) == 1
--
--   if not directory then
--     return
--   end
--
--   -- create a new, empty buffer
--   vim.cmd.enew()
--
--   -- wipe the directory buffer
--   vim.cmd.bw(data.buf)
--
--   -- open the tree
--   vim.cmd([[Neotree]])
--   -- require("nvim-tree.api").tree.open()
-- end
--
-- api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
