"scriptencoding utf8

if has('vim_starting')
  " Use Vim settings
  set nocompatible
endif

" ============================================================================
"  VARIABLES
"
let mapleader="\<Space>"

" Bool
let s:true  = 1
let s:false = 0

" Platform
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin  = has('win32unix')
let s:is_mac     = !s:is_windows && !s:is_cygwin
        \ && (has('mac') || has('macunix') || has('gui_macvim') || 
        \     (!executable('xdg-open') && system('uname') =~? '^darwin'))
let s:is_linux   = !s:is_mac && has('unix')

" NeoBundle Path
if s:is_windows
  let $DOTVIM = expand('~/vimfiles')
else
  let $DOTVIM = expand('~/.vim')
endif
let $VIMBUNDLE = $DOTVIM . '/bundle'
let $NEOBUNDLEPATH = $VIMBUNDLE . '/neobundle.vim'



" ============================================================================
"  NeoBundle Core

if has('vim_starting')
  " If NeoBundle is Not installed, Install it automatically.
  if !isdirectory(expand($NEOBUNDLEPATH))
    echo "Install NeoBundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim " . $NEOBUNDLEPATH)
  endif
  set runtimepath+=$NEOBUNDLEPATH
endif
let g:neobundle_default_git_protocol='https'

" BEGIN {{{
call neobundle#begin(expand($VIMBUNDLE))
NeoBundleFetch 'Shougo/neobundle.vim'


" ============================================================================
"  NeoBundle Install Packages

" Color Scheme {{{
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
" }}}

" Vim-Session {{{
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
" }}}

" HTML/CSS {{{
NeoBundle 'mattn/emmet-vim'
NeoBundle 'slim-template/vim-slim'
" }}}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
"NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'grep.vim'
"NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
"  \ 'insert' : 1,
"  \ 'filetypes': 'ruby',
"  \ }}
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'thinca/vim-quickrun', {
  \ 'autoload' : {
  \   'mappings' : [['n', '\r']],
  \   'commands' : ['QuickRun']
  \ }}
NeoBundle 'wakatime/vim-wakatime'
"NeoBundle 'vim-scripts/dbext.vim'
"NeoBundle 'Kuniwak/vint'

"" .や::を入力したときにオムニ補完が有効になるようにする
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"
"" 環境変数RSENSE_HOMEに'/usr/local/bin/rsense'を指定しても動く
"let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'

" EasyMotion {{{
" ==============
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_do_mapping = 0
" Find Motions
nmap <Leader>f <Plug>(easymotion-s2)
xmap <Leader>f <Plug>(easymotion-s2)
omap <Leader>f <Plug>(easymotion-s2)
" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
" Line Motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" keep cursor column with `JK` motions
let g:EasyMotion_startofline = 0
" General Configuration
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1
" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
" Search Motions
" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
" }}}


" NeoBundle END }}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck


" ============================================================================
"  COLOR SCHEME

set t_Co=256
colorscheme molokai
"colorscheme jellybeans
"colorscheme vividchalk 

" ============================================================================
"  BASIC SETUP

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set bomb
set binary
set ttyfast

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tabs (May be overriten by autocmd rules)
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Backup
set nobackup
"set nowritebackup
set noswapfile

" EOL
"set nofixeol

" ClipBoard integration with OS X
set clipboard=unnamed,autoselect

" ============================================================================
"  VISUAL SETTINGS

syntax on

" Disable cursol blink
set guicursor=a:blinkon0

set colorcolumn=80
set history=100
set list
if s:is_mac
  set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
end
set number
set showcmd
set ruler
set scrolloff=5
set mousehide
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P

if has('mouse')
  set mouse=a
endif

if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif


" ============================================================================
"  KEY MAPPING

inoremap jj <ESC>

" CTRL-U in insert mode deletes a lot
inoremap <C-U> <C-G>u<C-U>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

nmap s <C-W>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Don't use Ex mode, use Q for formatting
map Q gq


"inoremap <C-r>r <ESC>:QuickRun<CR>i<Right>

"" Only do this part when compiled with support for autocommands.
"if has("autocmd")
"
"  " Enable file type detection.  Use the default filetype settings, so that
"  " mail gets 'tw' set to 72,
"  " 'cindent' is on in C files, etc.
"  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on
"
"  " Put these in an autocmd group, so that we can delete them easily.
"  augroup vimrcEx
"  au!
"
"  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"
"  " When editing a file, always jump to the last known cursor position.
"  " Don't do it when the position is invalid or when inside an event handler
"  " (happens when dropping a file on gvim).
"  " Also don't do it when the mark is in the first line, that is the default
"  " position when opening a file.
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"    \   exe "normal! g`\"" |
"    \ endif
"
"  augroup END
"
"else
"
"  set autoindent		" always set autoindenting on
"
"endif " has("autocmd")

" カレントバッファの編集前後のDiff表示
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey


" ============================================================================
"  SETTINGS FOR Windows

if s:is_windows
  set guifont=MS_Gothic:h9:cSHIFTJIS
  set linespace=1
  if has('kaoriya')
    set ambiwidth=auto
    source $VIM/plugins/kaoriya/encode_japan.vim
    if !(has('win32') || has('mac')) && has('multi_lang')
      if !exists('$LANG') || $LANG.'X' ==# 'X'
        if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
          language ctype ja_JP.eucJP
        endif
        if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
          language messages ja_JP.eucJP
        endif
      endif
    endif
  endif
  set guioptions-=T

  " Menubar lang change to Japanese
  if has('gui_running')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
  endif
endif


" ============================================================================
"  SETTINGS FOR Japanease

if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
  set iminsert=0 imsearch=0
endif

