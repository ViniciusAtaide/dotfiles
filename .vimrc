" vim: set fdm=marker :

" #Bundles {{{
" Bundler that knows how to 'make' "{{{
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'sjl/gundo.vim'
NeoBundle "slava/vim-spacebars"
NeoBundle "Slava/vim-colors-tomorrow"
NeoBundle "whatyouhide/vim-gotham"
NeoBundle "sickill/vim-monokai"
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
"}}}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
" Insert/Delete brackets in pairs
NeoBundle 'jiangmiao/auto-pairs'

" Git wrapper
NeoBundle 'tpope/vim-fugitive'

" A lot of shortcuts for next/prev navigation, usually is [x and ]x for moving
" back and forth for X
NeoBundle 'tpope/vim-unimpaired'

NeoBundle 'dbakker/vim-projectroot'
NeoBundle 'mxw/vim-jsx'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'marijnh/tern_for_vim'
" Surrond plugin! Surrond text with a pair of anything (s in normal) "{{{
NeoBundle 'tpope/vim-surround'
"}}}

"}}}


NeoBundleLazy 'facebook/vim-flow', {
      \ 'autoload': {
      \ 'filetypes': 'javascript'
      \ }}

let g:flow#enable = 0
" Syntax definitions "{{{
NeoBundle "groenewege/vim-less"
NeoBundle "elzr/vim-json"
NeoBundle "tpope/vim-markdown"
NeoBundle "pangloss/vim-javascript"
NeoBundle "leafgarland/typescript-vim"
" Actually does much more than syntax highlighting but that's overkill for me
NeoBundle "kchmck/vim-coffee-script"
NeoBundle "hdima/python-syntax"
"}}}
NeoBundle "kshenoy/vim-signature"
NeoBundle "bling/vim-airline"
NeoBundle "easymotion/vim-easymotion"

call neobundle#end()

" Run and manage child processes, dependency of many other plugins "{{{
" Ultimate UI system for running fuzzy-search on different things {{{
" Always start insert mode
let g:unite_enable_start_insert = 1
let g:unite_source_rec_unit = 250 
let g:unite_source_rec_limit = 500 
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = "botright"
let g:unite_options_winwidth = 30
let g:unite_options_vertical = 1
" `ag` is a faster and better replacement for the standard `find`, let Unite use
" it if it exists and configure to properly use `.gitignore` or `.hgignore`
" files if those exist.
" To install `ag`: brew install ag
" or: https://github.com/ggreer/the_silver_searcher
if executable("ag")
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --ignore-dir=node_modules'
  let g:unite_source_grep_recursive_opt = ''
endif

"}}}
" Search settings
call unite#custom#source('file_rec', 'ignore_pattern', 'node_modules')
call unite#custom#profile('context.smartcase', 'files', 'smartcase')
call unite#custom#profile('buffer', 'context.ignorecase', 1)
"}}}

" Auto-completion plugin integrated with Unite and vimshell {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#min_keyword_length = 3

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
return neocomplete#close_popup() . "\<CR>"
" For no inserting <CR> key.
return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" No limit on the results of these searches
let g:unite_source_file_rec_max_cache_files = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"}}}
" Expand/shrink the visual selection by text-object blocks with `+` and `_` in
" the visual mode

" Undo/Redo tree

function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
  endtry
endfunction

autocmd BufEnter * call <SID>AutoProjectRootCD()


let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" Fugitive menu in Unite (depends on both Fugitive and Unite.vim) {{{
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.git = {}
let g:unite_source_menu_menus.git.description = 'git (Fugitive)'
let g:unite_source_menu_menus.git.command_candidates = [
  \['▷ git status       (Fugitive)',
      \'Gstatus'],
  \['▷ git diff         (Fugitive)',
      \'Gdiff'],
  \['▷ git commit       (Fugitive)',
      \'Gcommit'],
  \['▷ git log          (Fugitive)',
      \'exe "silent Glog | Unite quickfix"'],
  \['▷ git blame        (Fugitive)',
      \'Gblame'],
  \['▷ git stage        (Fugitive)',
      \'Gwrite'],
  \['▷ git checkout     (Fugitive)',
      \'Gread'],
  \['▷ git rm           (Fugitive)',
      \'Gremove'],
  \['▷ git mv           (Fugitive)',
      \'exe "Gmove " input("destino: ")'],
  \['▷ git push         (Fugitive, output buffer)',
      \'Git! push'],
  \['▷ git pull         (Fugitive, output buffer)',
      \'Git! pull'],
  \['▷ git prompt       (Fugitive, output buffer)',
      \'exe "Git! " input("comando git: ")'],
  \['▷ git cd           (Fugitive)',
      \'Gcd'],
  \]
" }}}

" Different stuff in the menu (depends on Unite.vim) {{{
let g:unite_source_menu_menus.all = {}
let g:unite_source_menu_menus.all.description = 'All things'
let g:unite_source_menu_menus.all.command_candidates = [
  \['▷ gundo toggle undo tree', 'GundoToggle'],
  \['▷ save file', 'write'],
  \['▷ save all opened files', 'wall'],
  \['▷ make the current window the only one on the screen', 'only'],
  \['▷ open file (Unite)', 'Unite -start-insert file'],
  \['▷ open file recursively (Unite)', 'Unite -start-insert file_rec/async'],
  \['▷ open buffer (Unite)', 'Unite -start-insert buffer'],
  \['▷ open directory (Unite)', 'Unite -start-insert directory'],
  \['▷ toggle the background color', 'ToggleBG'],
  \['▷ open the shell (VimShell)', 'VimShell'],
  \['▷ open a new shell (VimShell)', 'VimShellCreate'],
  \['▷ open a new shell in a tab (VimShell)', 'VimShellTab'],
  \['▷ open a node interpreter (VimShell)', 'VimShellInteractive node'],
  \['▷ install bundles (NeoBundleInstall)', 'NeoBundleInstall'],
  \['▷ clean bundles (NeoBundleClean)', 'NeoBundleClean'],
  \['▷ update bundles (NeoBundleUpdate)', 'NeoBundleUpdate'],
  \]
" }}}


if has("gui_running")
let g:vimshell_editor_command = "mvim"
endif
"}}}

" ##Visual
" Prettiness on the bottom {{{
" That weird colorful line on the bottom
let g:airline_theme='gotham'
set laststatus=2
set encoding=utf-8
if has("gui_running")
let g:airline_powerline_fonts=1
" Even special font for this crap
set guifont=Consolas:h10:cANSI
endif

function! AirlineOverride(...)
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = airline#section#create_left(['branch'])
let g:airline_section_c = airline#section#create_left(['%f'])
let g:airline_section_y = airline#section#create([])
endfunction
autocmd VimEnter * call AirlineOverride()

" }}}

" Visually sets marks

" Colorscheme {{{
set t_Co=256
let g:tomorrow_termcolors = 256
let g:tomorrow_termtrans = 0 " set to 1 if using transparant background
let g:tomorrow_diffmode = "high"

try
colorscheme gotham
catch
  " we don't have this theme or it throws
endtry

"set background=light
set background=dark

" }}}

" }}}

" #Essentials {{{
" Turns syntax highlighting on
syntax enable

" Numbers, can you imagine?
set number

" Extra info on the bottom
set ruler

" Highlight current line
set cursorline

" Leader key is comma
let mapleader = ","

" ##Search tweaks {{{
set hlsearch
set incsearch
" Kill current search
nnoremap <silent> <Leader>/ :nohlsearch<CR>
"}}}


" ##AutoCmd essentials{{{
if has("autocmd")
" Enable file type detection
filetype on
filetype plugin indent on
endif
"}}}

" Prefer spaces to tabs and set size to 2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Allows to use mouse to move the cursor
set mouse=a

" Tweak the behavior of <Tab> in command mode
set wildmenu
set wildmode=longest:full,full

" Indentation tweaks:
" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" dumb indent
set autoindent

" No need to switch back to English in normal mode
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" Buffers tweaks
" Allow to switch from changed buffer
set hidden

" Splits tweaks {{{
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" I want new splits to appear to the right and to the bottom of the current
set splitbelow
set splitright
" }}}


" Wrapping tweaks "{{{
set wrap
set linebreak
set textwidth=80
set formatoptions=cq " format using textwidth, including comments and gq
"}}}

" I can type :help myself, thanks.
noremap <F1> <Esc>

" Save undo history persistently on disk, takes extra space "{{{
if has('persistent_undo')         " persistend undo history
" create the directory if it doesn't exist
silent !mkdir ~/.vim/undo > /dev/null 2>&1
set undofile                  " Save undo's after file closes
set undodir=~/.vim/undo/      " where to save undo histories
set undolevels=100            " How many undos
set undoreload=3000           " number of lines to save for undo
endif
"}}}

" Gaming swap files "{{{
" create the directory if it doesn't exist
set backupdir=~/.vim/swap/
set directory=~/.vim/swap/
"}}}

" MacVim or GVim options "{{{
if has("gui_running")
set guioptions-=L
set guioptions-=r
set guioptions-=m
set guioptions-=T
endif
"}}}

" Semicolon is just colon
nnoremap ; :

" Tweak ESC to be 'jk' typed fast
imap jk <ESC>
" Do not disable it, since kinesis has cool remap to the left thumb
" imap <ESC> <nop>
"}}}

" #Leader mappings {{{
" Show/hide invisibles by <leader>l
nnoremap <leader>l :set list!<CR>
" Toggle spelling on/off
nnoremap <silent> <leader>s :set spell!<CR>
" Tab movements
nnoremap <leader>m :tabn<CR>
nnoremap <leader>n :tabp<CR>
" Save file quickly
nnoremap <leader>w :w<CR>
" Quickly cd to directory
nnoremap <leader>D :Unite -start-insert directory<CR>
" Paste from the yank history
nnoremap <leader>p :Unite -start-insert history/yank<CR>
" Trigger the git menu
nnoremap <leader>g :Unite -silent -start-insert menu:git<CR>
" Open all menus with useful stuff
nnoremap <leader>j :Unite -silent -start-insert menu:all menu:git<CR>
" }}}

" #Other mappings {{{
" Quickly open files or buffers
nnoremap <C-n> :Unite -start-insert file file/new -profile-name=files<CR>
nnoremap <leader><C-n> :Unite -start-insert file_rec/async<CR>
"}}}

noremap <C-s> :w<CR>
" Automatically reload vimrc when it's saved "{{{
augroup VimrcSo
  au!
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
augroup END
"}}}

" Set shell to bash (because vim would conflict with the default system shell)
set shell=c:\\cygwin64\\cygwin.bat

" For the VimR search rules
set wildignore=*.so,*.a,*.pyc,.meteor,.build.*,.git,node_modules

" This is good enough for folding and is not as slow as "syntax"
" set foldmethod=indent

nnoremap <C-p> :Unite -start-insert -buffer-name=buffer -profile-name=buffer file_rec<CR>
nnoremap / :Unite -start-insert line<CR>

let g:unite_source_history_yank_enable = 1
nnoremap <C-y> :Unite history/yank<CR>
set clipboard=unnamed

nmap <leader>; <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1

NeoBundleCheck
