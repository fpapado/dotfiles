call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdcommenter'

Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'

Plug 'elmcast/elm-vim'
Plug 'lervag/vimtex'
Plug 'fs111/pydoc.vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'slashmili/alchemist.vim'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'

Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/seoul256.vim'
call plug#end()

" TODO: add lazy-loading to plugins above
"" Backup and swap files
""
set backupdir=~/.local/share/nvim/_backup/    " where to put backup files.
set directory=~/.local/share/nvim/_temp//      " where to put swap files.

" Use deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Map the space key to leader
let mapleader="\<SPACE>"

" Search {
  set hlsearch
  set incsearch
  set ignorecase          " Make searching case insensitive
  set smartcase           " ... unless the query has capital letters.
  set gdefault            " Use 'g' flag by default with :s/foo/bar/.
  set magic               " Use 'magic' patterns (extended regular expressions).

  " Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
  endif
" }

" Formatting {
  set encoding=utf-8
  set showcmd
  set showmatch
  set showmode

  set cursorline
  set cursorcolumn
  set number
  set ruler

  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

  set title
  set noerrorbells
  set modeline
  set esckeys

  " More natural splits
  set splitbelow
  set splitright

  if !&scrolloff
    set scrolloff=3       " Show next 3 lines while scrolling.
  endif
  if !&sidescrolloff
    set sidescrolloff=5   " Show next 5 columns while side-scrolling.
  endif

  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif
  set list                " Show problematic characters.
" }

" Configuration {
  " set autochdir           " Switch to current file's parent directory.

  " Remove special characters for filename
  set isfname-=:
  set isfname-==
  set isfname-=+

  " Map ; to :
  nnoremap ; :

  if &undolevels < 200
    set undolevels=200    " Number of undo levels.
   endif

   set undodir=~/.local/share/nvim/undodir
   set undofile
   set undoreload=10000

  " Path/file expansion in colon-mode.
  set wildmode=list:longest
  " set wildmenu
  set wildchar=<TAB>

  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^linux'
    set t_Co=16
  endif

  " Remove trailing spaces.
  function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
  endfunction
  " FIXME: Do not call this on makefile and sv files.
  autocmd BufWritePre * call TrimWhitespace()
  nnoremap <leader>W :call TrimWhitespace()<CR>

  " Diff options
  set diffopt+=iwhite

  " Stop cursor from jumping over wrapped lines
  nnoremap j gj
  nnoremap k gk
  " Make HOME and END behave like shell
  inoremap <C-E> <End>
  inoremap <C-A> <Home>
" }

" UI Options {
  " Colorscheme
  set termguicolors
  set background=dark
  " let g:gruvbox_italic=1
  let g:nord_italic_comments = 1
  colorscheme nord

  let g:seoul256_background = 235
  " colo seoul256

  " Also highlight all tabs and trailing whitespace characters.
  " highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  " match ExtraWhitespace /\s\+$\|\t/
" }

" Keybindings {
  " Save file
  nnoremap <Leader>w :w<CR>

  " Copy and paste from system clipboard (Might require xsel/xclip install)
  vmap <Leader>y "+y
  vmap <Leader>d "+d
  nmap <Leader>p "+p
  nmap <Leader>P "+P
  vmap <Leader>p "+p
  vmap <Leader>P "+P

  " Move between buffers
  nmap <Leader>l :bnext<CR>
  nmap <Leader>h :bprevious<CR>

  " jj to exit insert
  inoremap jj <Esc>
" }

" Neomake customisation {
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END

  let g:neomake_markdown_enabled_makers = []
  let g:neomake_elixir_enabled_makers = ['mix', 'credo']
" }

" CtrlP customisation {
  " Open file menu
  nnoremap <Leader>o :CtrlP<CR>
  " Open buffer menu
  nnoremap <Leader>b :CtrlPBuffer<CR>
  " Open most recently used files
  nnoremap <Leader>f :CtrlPMRUFiles<CR>

  nnoremap <C-a> :CtrlPBuffer<CR>
  set wildignore+=*/node_modules*
  set wildignore+=*/public/lib*
" }

" NERDCommenter {
  let g:NERDSpaceDelims = 1
  nmap <C-_> <leader>c<Space>
  vmap <C-_> <leader>c<Space>
" }

" Airline customisation {
  let g:airline#extensions#tabline#enabled = 2
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#right_sep = ' '
  let g:airline#extensions#tabline#right_alt_sep = '|'
  let g:airline_left_sep = ' '
  let g:airline_left_alt_sep = '|'
  let g:airline_right_sep = ' '
  let g:airline_right_alt_sep = '|'
  let g:airline_theme = 'nord'
" }

" Go config {
  let g:deoplete#sources#go#gocode_binary = '~/gowork/bin/gocode'
  let g:go_bin_path = expand("~/gowork/bin")
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_types = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
" }

" Goyo and limelight {
  " autocmd! FileType markdown GoyoEnter Limelight
  " autocmd! FileType markdown  GoyoLeavev Limelight!
" }

" Elixir config {
  au FileType elixir nmap <leader>t :Mix test<CR>
" }

" Elm config {
  let g:elm_format_autosave = 1

  " (Assuming settings like the following)
  let g:deoplete#omni#functions = {}
  let g:deoplete#sources = {}
  let g:deoplete#sources._ = ['file', 'neosnippet']
  let g:deoplete#omni#input_patterns = {}

  let g:deoplete#omni#functions.elm = ['elm#Complete']
  let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
  let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._
" }

" Rust confg {
  let g:rustfmt_autosave = 1
" }

" Python Config {
  au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

  let g:neomake_python_enabled_makers = ['flake8', 'pep8']

  " E501 is line length of 80 characters
  let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501'], }
  let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=105'], }
" }
