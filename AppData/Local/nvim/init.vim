"cd ~
let g:ale_completion_enabled = 1
set ignorecase
"set smartcase
set nu
syntax on

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'dense-analysis/ale'
Plug 'nightsense/cosmic_latte'
Plug 'vim-scripts/oceanlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'dzeban/vim-log-syntax'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'

call plug#end()

set background=dark
colorscheme cosmic_latte
let g:airline_powerline_fonts = 0
let g:airline_theme='deus'
" Enable integration of status line with ale
let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'json': ['prettier']
\}

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

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' '~' | wincmd p | ene | exe 'cd ~' | endif

let NERDTreeShowHidden=1

map <C-n> :NERDTreeToggle<CR>
map <S-n> :NERDTreeFocus<CR>
map <C-f> :ALEFix<CR>
map <C-s> :w<CR>
map <C-z> :u<CR>

function! FormatBufferAsJson()
    :set filetype=json
    :ALEFix
endfunction

:command! CopyExpandCurrentFilePath let @+ = expand("%:p")
:command! CopyCurrentFilePath let @+ = expand("%")
:command! ReloadConfig :so $MYVIMRC

" TABS ========================================================

:set tabstop=4
:set expandtab
:set softtabstop

autocmd Filetype json setlocal tabstop=2
autocmd Filetype json setlocal expandtab
autocmd Filetype json setlocal softtabstop
