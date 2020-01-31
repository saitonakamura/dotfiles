let system = 'Unknown'
if has('unix')
  let lines = readfile('/proc/version')
  if lines[0] =~ "Microsoft"
    let system = 'LinuxWsl'
  else
    let system = 'Linux'
  endif
elseif has('win32')
  let system = 'Windows'
elseif has('macunix')
  let system = 'Macos'
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'

if system == 'Macos'
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

Plug 'junegunn/fzf.vim'

call plug#end()

set number
set clipboard=unnamed
set termguicolors
syntax on
set expandtab
set softtabstop=2
set shiftwidth=2
set nowrap

try
  set winblend=10
catch
endtry

set ignorecase
let mapleader = ','
set background=dark
try
  colorscheme onedark
catch
  colorscheme slate
endtry

try
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='deus'
  let g:airline#extensions#tabline#buffer_nr_show = 1
catch
  echo 'Airline is not installed, give :PlugInstall a try'
endtry

" Map Ctrl+s to save
map <C-s> :write<CR>

" Buffers
map <leader>b] :bnext<CR>
map <leader>b[ :bprevious<CR>
map <silent> <leader>bd :bdelete<CR>
map <silent> <leader>nb :Buffers<CR>

map <silent> <leader>c :Commands<CR>
" map <silent> <leader>nd :Cd<CR>
map <silent> <leader>nf :FZF<CR>

map <leader>[ <C-O>
noremap <leader>] <C-I>

command! ReloadConfig :source $MYVIMRC
