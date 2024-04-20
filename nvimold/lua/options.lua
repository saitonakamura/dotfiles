-- inspiration https://github.com/jdhao/nvim-config/blob/master/viml_conf/options.vim

-- Split window below/right when creating horizontal/vertical windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Time in milliseconds to wait for a mapped sequence to complete,
-- see https://unix.stackexchange.com/q/36882/221410 for more info
vim.opt.timeoutlen = 500

vim.opt.updatetime = 500 -- For CursorHold event

-- Use system clipboard for everything, makes it easier to work with other apps
vim.opt.clipboard = "unnamedplus"

-- Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
vim.opt.swapfile = false

-- Ignore certain files and folders when globing
vim.opt.wildignore:append({ "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe" })
vim.opt.wildignore:append({ "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**" })
vim.opt.wildignore:append({ "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico" })
vim.opt.wildignore:append({ "*.pyc", "*.pkl" })
vim.opt.wildignore:append({ "*.DS_Store" })
vim.opt.wildignore:append({ "*.aux", "*.bbl", "*.blg", "*.brf", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.xdv" })
-- TODO For some reason this breaks lsp navigation, need to investigate
-- vim.opt.wildignorecase = true -- ignore file and dir name cases in cmd-completion

-- General tab settings
vim.opt.tabstop = 2 -- number of visual spaces per TAB
vim.opt.softtabstop = 2 -- number of spaces in tab when editing
vim.opt.shiftwidth = 2 -- number of spaces to use for autoindent
vim.opt.expandtab = true -- expand tab to spaces so that tabs are spaces

-- Set matching pairs of characters and highlight matching brackets
vim.opt.matchpairs:append({ "<:>" })

-- Show line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.numberwidth = 4
-- vim.opt.signcolumn = "yes:1"

-- Ignore case in general, but become case-sensitive when uppercase is present
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false

-- Indent wrapped lines, not sure which one I prefer
-- vim.opt.breakindent = true
-- Break line at predefined characters
vim.opt.linebreak = true
-- Character to show before the lines that have been soft-wrapped
vim.opt.showbreak = "↪"

-- TODO need to set up proper completion first
-- List all matches and complete till longest common string
-- vim.opt.wildmode = "list:longest"

-- Minimum lines to keep above and below cursor when scrolling
vim.opt.scrolloff = 3

-- Use mouse to select and resize windows, etc.
vim.opt.mouse = { n = true, i = true, c = true } -- Enable mouse in several mode
vim.opt.mousemodel = "popup" -- Set the behaviour of mouse
vim.opt.mousescroll = { "ver:1", "hor:0" }

-- Disable showing current mode on command line since statusline plugins can show it.
-- TODO install statusline plugin
-- vim.opt.showmode = false
-- vim.opt.ruler = false

vim.opt.fileformats = { "unix", "dos" } -- Fileformats to use for new files

-- Ask for confirmation when handling unsaved or read-only files
vim.opt.confirm = true

-- Use list mode and customized listchars
-- TODO List mode looks too noisy for my taste, maybe less prominent symbols would solve it
-- vim.opt.list = true
vim.opt.listchars = { tab = "▸\\", extends = "❯", precedes = "❮", nbsp = "␣" }

-- Persistent undo even after you close a file and re-open it
vim.opt.undofile = true

-- Do not show "match xx of xx" and other messages during auto-completion
vim.opt.shortmess:append({ c = true })

-- Disable showing intro message (:intro)
vim.opt.shortmess:append({ I = true })

-- Completion behaviour
-- set completeopt+=noinsert  -- Auto select the first completion entry
-- set completeopt+=menuone -- Show menu even if there is only one item
-- set completeopt-=preview -- Disable the preview window
vim.opt.completeopt = "menuone,noselect"

vim.opt.pumheight = 10 -- Maximum number of items to show in popup menu
-- TODO check what's this about
vim.opt.pumblend = 10 -- pseudo transparency for completion menu
vim.opt.winblend = 0 -- pseudo transparency for floating window

-- TODO check when setting completion
-- Insert mode key word completion setting
-- set complete+=kspell complete-=w complete-=b complete-=u complete-=t

vim.opt.virtualedit = "block" -- Virtual edit is useful for visual block edit

vim.opt.synmaxcol = 250 -- Text after this column number is not highlighted

vim.opt.startofline = false

-- TODO port condition to lua
-- TODO find out about grep in vim
-- External program to use for grep command
-- if executable('rg')
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
-- endif

-- Enable true color support. Do not set this option if your terminal does not
-- support true colors! For a comprehensive list of terminals supporting true
-- colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
vim.opt.termguicolors = true

