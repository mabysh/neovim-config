"
" Vim initialization
" ------------------

" Global Mappings "{{{
" Use spacebar as leader and ; as secondary-leader
" Required before loading plugins!
let g:mapleader="\<Space>"
let g:maplocalleader=';'

" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>
nnoremap m        <Nop>
xnoremap m 	  <Nop>
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-x> :bd<CR>
nmap <C-n> :VimFilerExplorer<CR>

" Plugins ==================== {{{
call plug#begin( '~/.config/nvim/bundle')

Plug 'rust-lang/rust.vim'
Plug 'roxma/nvim-completion-manager'
"Plug 'racer-rust/vim-racer'
"Plug 'roxma/nvim-cm-racer'
Plug 'joshdick/onedark.vim'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'thaerkh/vim-workspace'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-unknown-linux-musl' }
"Plug 'neomake/neomake'
call plug#end()
"}}}

" ================ General Config ==================== {{{
"set termguicolors
set title                                                                       "change the terminal's title
"set number                                                                      "Line numbers are good
set history=500                                                                 "Store lots of :cmdline history
set showcmd                                                                     "Show incomplete cmds down the bottom
set noshowmode                                                                  "Hide showmode because of the powerline plugin
set gdefault                                                                    "Set global flag for search and replace
set gcr=a:blinkon500-blinkwait500-blinkoff500                                   "Set cursor blinking rate
set cursorline                                                                  "Highlight current line
set smartcase                                                                   "Smart case search if there is uppercase
set ignorecase                                                                  "case insensitive search
set showmatch                                                                   "Highlight matching bracket
set nostartofline                                                               "Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=0                                               "Reduce Command timeout for faster escape and O
set fileencoding=utf-8                                                          "Set utf-8 encoding on write
set wrap                                                                        "Enable word wrap
set linebreak                                                                   "Wrap lines at convenient points
set listchars=tab:\ \ ,trail:·                                                  "Set trails for tabs and spaces
set list                                                                        "Enable listchars
set hidden
set lazyredraw                                                                  "Do not redraw on registers and macros
set background=dark                                                             "Set background to dark
set hidden                                                                      "Hide buffers in background
set splitright                                                                  "Set up new vertical splits positions
set splitbelow                                                                  "Set up new horizontal splits positions
set path+=**                                                                    "Allow recursive search
set inccommand=split                                                            "Show substitute changes immidiately in separate split
set fillchars+=vert:\│                                                          "Make vertical split separator full line
set pumheight=30                                                                "Maximum number of entries in autocomplete popup

syntax on                                                                       "turn on syntax highlighting

" }}}
" ================ Turn Off Swap Files ============== {{{

set noswapfile
set nobackup
set nowb

" }}}
" ================ Persistent Undo ================== {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" }}}
" ================ Indentation ====================== {{{

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set nofoldenable

" }}}
" ================ Auto commands ====================== {{{

augroup vimrc
    autocmd!
augroup END

"autocmd vimrc BufWritePre * :call StripTrailingWhitespaces()                    "Auto-remove trailing spaces

" }}}
" ================ Completion ======================= {{{

set wildmode=list:full
set wildignore=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Ale =============================== {{{
let g:ale_linters = {'rust': ['cargo']}
let g:ale_rust_cargo_use_check = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '%s'
let g:ale_echo_msg_warning_str = 'Warning'
let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
let g:ale_set_loclist = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_selectionUI = 'fzf'
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_windowLogMessageLevel = "Info"
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_changeThrottle = 0.5

let g:LanguageClient_rootMarkers = {
        \ 'javascript': ['project.json'],
        \ 'rust': ['Cargo.toml'],
        \ }

nnoremap <silent> <leader>doc :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>rn  :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>ref  :call LanguageClient_textDocument_references()<CR>
" ================ Scrolling ======================== {{{

set scrolloff=8                                                                 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=5

" }}}
" ================ Colorscheme setup ================ {{{
set t_Co=256
colorscheme onedark
let g:bold_highlight_groups = ['Function', 'Statement', 'Todo', 'CursorLineNr', 'MatchParen', 'StatusLine']
let g:onedark_terminal_italics = 1                                              "Enable italic font
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" ================ Airline ========================== {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='onedark'
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" ================ Workspace ====================== {{{
nnoremap <leader>s :ToggleWorkspace<CR>

" ================ VimFiler ======================= {{{
:let g:vimfiler_as_default_explorer = 1

" ================ DelimitMate ==================== {{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space=1
let b:delimitMate_quotes = "\" `"
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
"  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:}"
  "au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"
augroup END

" ================= Tagbar ======================== {{{
nmap <silent> <leader>tag :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"Rust ctags config
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}

" ============== RUST ============================ {{{
let g:rustfmt_autosave = 1
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

" ============== FZF ============================= {{{
"default command
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
 \                         : fzf#vim#with_preview('right:50%'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

"
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Key mappings
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>f :Files<CR>
nmap <silent> <leader>loc :Locate ""<CR>
nmap <silent> <leader>hst :History<CR>
nmap <silent> <leader>com :Commits<CR>
nmap <silent> <leader>bcom :BCommits<CR>
nmap <silent> <leader>rg :Rg<CR>

