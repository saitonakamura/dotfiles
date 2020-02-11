let system = 'Unknown'
if has('unix') && filereadable('/proc/version')
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
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if system == 'Macos'
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

Plug 'junegunn/fzf.vim'

call plug#end()

set termguicolors
syntax on

set background=dark
try
  colorscheme onedark
catch
  colorscheme slate
endtry

set number
set clipboard=unnamed
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

let g:NERDTreeShowHidden = 1

try
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='deus'
  let g:airline#extensions#tabline#buffer_nr_show = 1
  "let g:airline#extensions#tabline#left_sep = ' '
  "let g:airline#extensions#tabline#left_alt_sep = '|'
  "let g:airline#extensions#tabline#formatter = 'unique_tail'
catch
  echo 'Airline is not installed, give :PlugInstall a try'
endtry

" COC.NVIM

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <C-TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<C-TAB>" :
"      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
endfunction

" Trigger completion.
inoremap <silent><expr> <alt-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigate diagnostics
nmap <silent> <leader>d[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>d] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Find symbol of current document
nnoremap <silent> <leader>gs :<C-u>CocList outline<cr>

" Use K to show documentation in preview window
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>rf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OrganizeImports   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Map Ctrl+s and ,w to save
map <C-s> :write<CR>
map <silent><leader>w :write<CR>

" Buffers
map <leader>b] :bnext<CR>
map <leader>b[ :bprevious<CR>
map <silent> <leader>bd :bdelete<CR>
map <silent> <leader>nb :Buffers<CR>

command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'fd --type d . /',
  \  'sink': 'cd'}))

" Fuzzy searches with fzf
map <silent> <leader>c :Commands<CR>
map <silent> <leader>nd :Cd<CR>
map <silent> <leader>nf :FZF<CR>
map <silent> <leader>f :FZF<CR>

map <leader>[ <C-O>
noremap <leader>] <C-I>

command! CopyCurrentFilePath let @+ = expand("%:p")
map <silent> <leader>acp :CopyCurrentFilePath<CR>

command! ReloadConfig :source $MYVIMRC

function! CocInstallMine()
  :CocInstall
    \ coc-json
    \ coc-tsserver
    \ coc-css
    \ coc-vimlsp
    \ coc-eslint
endfunction
