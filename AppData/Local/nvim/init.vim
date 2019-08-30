let g:ale_completion_enabled = 1
set ignorecase
set smartcase
set nu
syntax on

call plug#begin('~/.config/nvim/plugged')

Plug 'w0rp/ale'
Plug 'nightsense/cosmic_latte'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'

call plug#end()

set background=dark
colorscheme cosmic_latte
let g:airline_powerline_fonts = 0
let g:airline_theme='deus'
" Enable integration of status line with ale
let g:airline#extensions#ale#enabled = 1

if has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>		"+gP
    map <S-Insert>		"+gP

    cmap <C-V>		<C-R>+
    cmap <S-Insert>		<C-R>+
endif

autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
