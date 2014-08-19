set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on
filetype on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
let mapleader = ","
set ignorecase
set hlsearch
set autoindent
set encoding=utf-8
set backspace=indent,eol,start
set ts=2 sts=2 sw=2 expandtab

set smartcase
set gdefault
set incsearch
set showmatch

set t_Co=256
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set list
set guifont=Meslo
set guioptions=aAc
set guioptions=Be
set relativenumber
set noswapfile
set visualbell
set cursorline

if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

set background=dark
let g:solarized_termcolors=256
let g:railscasts_termcolors=256
colorscheme solarized

set previewheight=20

hi User1 ctermbg=white  ctermfg=black guibg=#89A1A1 guifg=#002836
hi User2 ctermbg=red  ctermfg=white guibg=#aa0000 guifg=#89a1a1

