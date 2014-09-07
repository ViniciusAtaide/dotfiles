set nocompatible
execute pathogen#infect()
syntax enable
filetype plugin indent on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'cmather/vim-meteor-snippets'
Plugin 'Townk/vim-autoclose'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid'
Plugin 'scrooloose/nerdtree'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Valloric/YouCompleteMe'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'

call vundle#end()
let mapleader = ","
set ignorecase
set hlsearch
set autoindent
set encoding=utf-8
set backspace=indent,eol,start
set ts=2 sts=2 sw=2 expandtab

nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>n :CtrlP<CR>
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> :w<CR>

set t_Co=256
set smartcase
set gdefault
set incsearch
set showmatch

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set mouse=a
set list
set guioptions=Be
set guifont=Ubuntu\ Mono\ 12
set relativenumber
set noswapfile
set visualbell
set cursorline

set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
set previewheight=20

hi User1 ctermbg=white    ctermfg=black   guibg=#89A1A1 guifg=#002B36
hi User2 ctermbg=red      ctermfg=white   guibg=#aa0000 guifg=#89a1a1

au FocusLost * silent! wa
set autowriteall

