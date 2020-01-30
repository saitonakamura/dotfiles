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

if system == 'Macos' || system == 'Linux'
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

Plug 'junegunn/fzf.vim'

call plug#end()

set nu
syntax on
set ignorecase
set background=dark
colorscheme onedark
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
