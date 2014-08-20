set nocompatible
execute pathogen#infect()
syntax enable
filetype plugin indent on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'


call vundle#end()
let mapleader = ","
set ignorecase
set hlsearch
set autoindent
set encoding=utf-8
set backspace=indent,eol,start
set ts=2 sts=2 sw=2 expandtab

nnoremap <leader>m :NERDTreeToggle<CR>

set t_Co=256
set smartcase
set gdefault
set incsearch
set showmatch

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set list
set listchars=tab:▸\ ,eol:¬,nbsp:⋅,trail:•
set guifont=SourceCodePro
set guioptions=aAc
set guioptions=Be
set relativenumber
set noswapfile
set visualbell
set cursorline

set background=light
let g:hybrid_use_Xresources = 1
colorscheme hybrid
set previewheight=20

hi User1 ctermbg=white    ctermfg=black   guibg=#89A1A1 guifg=#002B36
hi User2 ctermbg=red      ctermfg=white   guibg=#aa0000 guifg=#89a1a1

function! GetCWD()
return expand(":pwd")
endfunction

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
if !exists("*synstack")
  return
endif
echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,
"name")')
endfunc

function! IsHelp()
return &buftype=='help'?' (help) ':''
endfunction 

function! GetName()
return expand("%:t")==''?'<none>':expand("%:t")
endfunction

set statusline=%1*[%{GetName()}]\ 
set statusline+=%<pwd:%{getcwd()}\ 
set statusline+=%2*%{&modified?'\[+]':''}%*
set statusline+=%{IsHelp()}
set statusline+=%{&readonly?'\ (ro)\ ':''}
set statusline+=[
set statusline+=%{strlen(&fenc)?&fenc:'none'}\|
set statusline+=%{&ff}\|
set statusline+=%{strlen(&ft)?&ft:'<none>'}
set statusline+=]\ 
set statusline+=%=
set statusline+=c%c
set statusline+=,l%l
set statusline+=/%L\ 

set laststatus=2
