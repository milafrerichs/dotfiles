" ========================================================================
" Vundle stuff
" ========================================================================
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kchmck/vim-coffee-script'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'JamshedVesuna/vim-markdown-preview'

" Colors
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Use the colorscheme from above
colorscheme jellybeans

let mapleader = " "

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ========================================================================
" Ruby stuff
" ========================================================================
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

" ========================================================================
" Test stuff
" ========================================================================
map <Leader>t :w<cr>:call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>



let g:rspec_command = "Dispatch bin/rspec {spec}"

set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set laststatus=2  " Always show status line.
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set number
set bg=light
set encoding=utf-8
set ignorecase
set tabstop=2
set shiftwidth=2
set expandtab

highlight StatusLine ctermfg=black ctermbg=green
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Code Style
let g:vimrubocop_config = '~/dotfiles/rubocop.yml'
let g:syntastic_javascript_checkers = ['standard']

" Markdown
let vim_markdown_preview_toggle = 1
let vim_markdown_preview_hotkey = '<C-m>'
let vim_markdown_preview_github = 1
let vim_markdown_preview_temp_file = 1

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  autocmd FileType javascript setlocal ai ts=2 sw=2 sts=2 et
augroup END

set secure
