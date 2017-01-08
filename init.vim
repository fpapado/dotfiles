call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'ervandew/supertab'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'joukevandermaas/vim-ember-hbs'
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
  set showcmd
  set showmatch
  set showmode

  set cursorline
  set number
  set ruler

  set expandtab
  set tabstop=2
  set shiftwidth=2

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
  let g:gruvbox_italic=1
  colorscheme gruvbox

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
  let g:airline_theme = 'gruvbox'
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

" Elxir config {
  au FileType elixir nmap <leader>t :Mix test<CR>
" }
