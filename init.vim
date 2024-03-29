function! GetSystem()
  let l:system = 'Unknown'

  if has('unix') && filereadable('/proc/version')
    let lines = readfile('/proc/version')
    if lines[0] =~ "Microsoft"
      let l:system = 'LinuxWsl'
    else
      let l:system = 'Linux'
    endif
  elseif has('win32')
    let l:system = 'Windows'
  elseif has('macunix')
    let l:system = 'Macos'
  endif
  
  return l:system
endfunction

let s:system = GetSystem()

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
" Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'rakrvim-one'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'janko/vim-test'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'reasonml-editor/vim-reason-plus'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'sbdchd/neoformat'

if s:system == 'Macos'
  " Plug '/usr/local/opt/fzf'
else
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

" set completeopt=menu,menuone,noselect



" Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
" command! -nargs=0 OrganizeImports   :call     CocAction('runCommand', 'editor.action.organizeImport')

" command! -bang -nargs=* RipGrep :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --sort=path".<q-args>, 1, <bang>0)
" nmap <silent> <leader>ng :RipGrep

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
"   \ {'source': 'fd --type d . /',
"   \  'sink': 'cd'}))
command! CopyCurrentFilePath let @+ = expand("%:p")

command! ReloadConfig :source $MYVIMRC

command! GoToCurrentFileDir :edit %:p:h

" function! CocInstallMine()
"   :CocInstall
"     \ coc-json
"     \ coc-tsserver
"     \ coc-css
"     \ coc-vimlsp
"     \ coc-eslint
"     \ coc-prettier
" endfunction

function SetLightTheme()
  set background=light
  colorscheme onehalflight

  let $BAT_THEME='OneHalfLight'

  let g:airline_theme='onehalflight'
  try
    AirlineTheme onehalflight
  catch
  endtry
endfunction

function SetDarkTheme()
  set background=dark
  colorscheme onehalfdark

  let $BAT_THEME='OneHalfDark'

  let g:airline_theme='onehalfdark'
  try
    AirlineTheme onehalfdark
  catch
  endtry
endfunction

function SetCurrentSystemTheme()
  let l:theme = 'light'
  let l:system = GetSystem()

  if l:system == 'Macos'
    let l:mode = systemlist('defaults read -g AppleInterfaceStyle')[0]
    if l:mode == 'Dark'
      let l:theme = 'dark'
    endif
  elseif l:system == 'Windows' || l:system == 'LinuxWsl'
    let l:appsUseLightTheme = systemlist('reg.exe query "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme | sed "2 s/.*//" | sed "3 s/^.*0x//g" | sed "/^\s*$/d"')[0]

    if l:appsUseLightTheme == 0
      let l:theme = 'dark'
    endif
  endif
  
  if l:theme == 'dark'
    call SetDarkTheme()
  else
    call SetLightTheme()
  endif
endfunction

command! SetLightTheme :call SetLightTheme()
command! SetDarkTheme :call SetDarkTheme()
command! SetCurrentSystemTheme :call SetCurrentSystemTheme()

" set termguicolors
syntax on

set background=dark
try
  colorscheme onehalfdark
  " colorscheme one
catch
  colorscheme slate
endtry

set number relativenumber
set clipboard=unnamed
set expandtab
set softtabstop=2
set shiftwidth=2
set nowrap
set wildmode=longest:full
set autoread

try
  set winblend=10
catch
endtry

set ignorecase
let mapleader = ' '

let g:NERDTreeShowHidden = 1

try
  let g:airline_theme='onehalfdark'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  "let g:airline#extensions#tabline#left_sep = ' '
  "let g:airline#extensions#tabline#left_alt_sep = '|'
  "let g:airline#extensions#tabline#formatter = 'unique_tail'
catch
  echo 'Airline is not installed, give :PlugInstall a try'
endtry

call SetCurrentSystemTheme()


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
"      \ <SID>check_back_pace() ? "\<C-TAB>" :
"      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_pace() abort
"   let col = col('.') - 1
" endfunction

" Trigger completion.
" inoremap <silent><expr> <alt-pace> coc#refresh()

" imap <silent> <c-p> <Plug>(completion_trigger)
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" imap <silent> <c-p> 
" imap <tab> <C-X><C-O>
" imap <s-tab> <Plug>(completion_smart_s_tab)


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigate diagnostics
" nmap <silent> <leader>d[ <Plug>(coc-diagnostic-prev)
" nmap <silent> <leader>d] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" nmap <silent> <leader>gd <Plug>(coc-definition)
" nmap <silent> <leader>gt <Plug>(coc-type-definition)
" nmap <silent> <leader>gi <Plug>(coc-implementation)
" nmap <silent> <leader>gr <Plug>(coc-references)

" Find symbol of current document
" nnoremap <silent> <leader>gs :<C-u>CocList outline<cr>

" Use K to show documentation in preview window
" nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>ar <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>af  <Plug>(coc-format-selected)
" nmap <leader>af  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

function! ChangeDirToPrj()
   let l:Args = argv()
   if len(l:Args) != 1 " do it only when a single folder was passed to Vim as arg
      return
   endif
   if isdirectory(l:Args[0])
      exec 'chdir ' .. l:Args[0]
   endif
endfunction

augroup VIMRC
   autocmd!
   autocmd VimEnter * call ChangeDirToPrj()
augroup END

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>rf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)


" NAVIGATION
nnoremap <leader>[ <C-o>
nnoremap <leader>] <C-i>

nnoremap <leader>b] :bnext<CR>
nnoremap <leader>b[ :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>bD :bdelete!<CR>
nnoremap <silent> <leader>nb :Buffers<CR>
nnoremap <leader>nt[ :tabprevious<CR>
nnoremap <leader>nt] :tabnext<CR>

nnoremap <silent> <leader>; :
vnoremap <silent> <leader>; :

" nnoremap <leader>d[ :action GotoPreviousError<CR>
" nnoremap <leader>d] :action GotoNextError<CR>

" nnoremap <silent> <leader>nt :action ActivateTerminalToolWindow<CR>
nnoremap <silent> <leader>np :NERDTreeFind<CR>
nnoremap <silent> <leader>qp :NERDTreeClose<CR>
" nnoremap <silent> <leader>nb :Buffers<CR>
nnoremap <silent> <leader>nb <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>nf <cmd>Telescope live_grep<CR>


" " GOTO
" " nnoremap <silent> <leader>gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
" " nnoremap <silent> <leader>gt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap <silent> <leader>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
" " nnoremap <silent> <leader>gi :call LanguageClient#textDocument_implementation()<CR>
" nnoremap <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
" " nnoremap <silent> <leader>gr :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
" " nnoremap <silent> <leader>gs :call LanguageClient#workspace_symbol()<CR>
" nnoremap <silent> <leader>gs <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" " nnoremap <silent> <leader>gu :action GotoTest<CR>

" nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>c <cmd>Telescope commands<CR>
" nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>f <cmd>Telescope git_files<CR>
nnoremap <silent> <leader>F <cmd>Telescope find_files<CR>
" nnoremap <silent> <leader>e :action SearchEverywhere<CR>
" map <silent> <leader>nd :Cd<CR>
" nnoremap <silent> <leader>m :Maps<CR>
nnoremap <silent> <leader>m <cmd>Telescope keymaps<CR>


" " PREVIEW
" nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
" " noremap <A-Space> :call LanguageClient#textDocument_completion()<CR>
" inoremap <A-Space> <cmd>lua vim.lsp.buf.completion()<CR>
" " nnoremap <silent> <leader>pd :call QuickImplementations<CR>
" " nnoremap <silent> <leader>pr :call ShowUsages<CR>
" " nnoremap <silent> <leader>pb :call RecentLocations<CR>
" " nnoremap <silent> <leader>ps :call FileStructurePopup<CR>
" " nnoremap <silent> <leader>ps :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> <leader>ps <cmd>lua vim.lsp.buf.document_symbol()<CR>

" " FORMAT FIXES REFACTORINGS
" " nnoremap <silent> <leader>ar :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <leader>ar <cmd>lua vim.lsp.buf.rename()<CR>
" " nnoremap <silent> <leader>am :call LanguageClient#textDocument_codeAction()<CR>
" " vnoremap <silent> <leader>am :call LanguageClient#textDocument_codeAction()<CR>
" nnoremap <silent> <leader>am <cmd>lua vim.lsp.buf.code_action()<CR>
" vnoremap <silent> <leader>am <cmd>lua vim.lsp.buf.code_action()<CR>
" " nnoremap <silent> <leader>af :call LanguageClient#textDocument_formatting()<CR>
" " vnoremap <silent> <leader>af :call LanguageClient#textDocument_rangeFormatting()<CR>
" " nnoremap <silent> <leader>ap :call ReformatWithPrettierAction<CR>
" " nmap <silent> <leader>al :action

" " nnoremap <silent> <leader>rr :action RenameElement<CR>
" " nnoremap <silent> <leader>rm :action Move<CR>
" " nnoremap <silent> <leader>rv :action IntroduceVariable<CR>
" " nnoremap <silent> <leader>ri :action Inline<CR>
" " nnoremap <silent> <leader>rf :action ExtractMethod<CR>
" " nnoremap <silent> <leader>rp :action IntroduceParameter<CR>
let g:neoformat_try_node_exe = 1
nnoremap <silent> <leader>af :Neoformat<CR>
vnoremap <silent> <leader>af :Neoformat<CR>

" FILES
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader><S-w> :wall<CR>

" TESTS
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
" nnoremap <silent> <leader>td :action DebugClass<CR>
" nnoremap <silent> <leader>tr :action RerunTest<CR>

" GIT
" nnoremap <silent> <leader>vs :action Git.Branches<CR>
" nnoremap <silent> <leader>vS :action Git.CreateNewBranch<CR>
nnoremap <silent> <leader>vc :Git commit<CR>
nnoremap <silent> <leader>vv :Git<CR>
nnoremap <silent> <leader>vp :Git push<CR>
" nnoremap <silent> <leader>vP :Gpush!<CR>
nnoremap <silent> <leader>vb :Git blame<CR>
nnoremap <silent> <leader>vl :Git pull<CR>
nnoremap <silent> <leader>vf :Git fetch<CR>

" HELP
nmap <silent> <leader>h <cmd>Telescope help_tags<CR>

" ETC
" nnoremap <leader>/ :nohlsearch<CR>
" nnoremap / :action Find<CR>
" nnoremap g/ /
map <silent> <leader>acp :CopyCurrentFilePath<CR>

" DEBUG
" nnoremap <silent> <leader>db :action ToggleLineBreakPoint<CR>
" nnoremap <silent> <leader>do :action StepOver<CR>
" nnoremap <silent> <leader>di :action StepInto<CR>
" nnoremap <silent> <leader>ds :action SmartStepInto<CR>
" nnoremap <silent> <leader>du :action StepOut<CR>

luafile ~/dotfiles/vim.lua

