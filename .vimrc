if has('vim_starting')
  set nocompatible
endif

" ============================================================================
"  VARIABLES
"

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

" Vimrc path

  if s:is_windows
    let $DOTVIM = expand('~/vimfiles')
    let $VIMRC  = expand('~/_vimrc')
    let $GVIMRC = expand('~/_gvimrc')
  else
    let $DOTVIM = expand('~/.vim')
    let $VIMRC  = expand('~/.vimrc')
    let $GVIMRC = expand('~/.gvimrc')
  endif


" ============================================================================
"  DEIN SETTINGS
"

" Directory settings

  if s:is_mac
    let s:cache_home    = expand('~/.cache')
    let s:dein_dir      = s:cache_home . '/dein'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  elseif s:is_windows
    let s:cache_home    = expand('~\_cache')
    let s:dein_dir      = s:cache_home . '\dein'
    let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'
  else
    let s:cache_home    = expand('~/.cache')
    let s:dein_dir      = s:cache_home . '/dein'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  endif

" TOML file path

  if s:is_mac
  	let s:dein_toml = '~/.dein.toml'
  elseif s:is_windows
  	let s:dein_toml = '~\_dein.toml'
  else
  	let s:dein_toml = '~/.dein.toml'
  endif

" Install dein

  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    if s:is_mac
      execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    elseif s:is_windows
      set runtimepath^=~\_cache\dein\repos\github.com\Shougo\dein.vim
     "set runtimepath^=~\_cache\dein\repos\github.com\Shougo\dein.vim\
     "                                                               ~this \ is NG
     " if execute `fnamemodify(s:dein_repo_dir, ':p')` then,
     " returned path is '~\_cache\dein\repos\github.com\Shougo\dein.vim\'
     "                                                                 ~
    else
      execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif
  endif

" Load TOML

  if dein#load_state(expand(s:dein_dir))
    call dein#begin(s:dein_dir, [$MYVIMRC, s:dein_toml])
    call dein#load_toml(s:dein_toml)
    call dein#end()
    call dein#save_state()
  endif

" Install Plugins

  if dein#check_install()
    call dein#install()
  endif


" ============================================================================
"  GENERAL SETTINGS
"
  set backspace =indent,eol,start
  set clipboard =unnamed,autoselect
  set history   =100
  set tags      =tags;
  set viminfo   =

  if has('mouse')
    set mouse=a
  endif

" Text, tab, indent (May be overriten by autocmd rules)

  set expandtab
  set foldmethod =indent
  set foldlevel  =9
  set nowrap
  set smarttab
  set shiftwidth =2
  set tabstop    =4
  set softtabstop=0

" Encoding

  set encoding      =utf-8
  "set fileencoding  =utf-8
  set fileencodings =iso-2022-jp,euc-jp,utf-8,cp932,sjis,utf16le
  "set fileencodings =iso-2022-jp,cp932,sjis,euc-jp,utf-16le,utf-8
  "set bomb
  "set binary
  "set ttyfast

" Searching

  set nohlsearch
  set incsearch
  set ignorecase
  set smartcase

  " Search and jump then movo to center
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz

" Backup, Swap, Undo files
  " Turn off all, since many files are in git

  set nobackup
  "set backupdir=~/tmp/vim_bkp
  set noswapfile
  "set directory=~/tmp/vim_swp
  set noundofile
  "set undodir=~/tmp/vim_undo

" Window

  set splitbelow
  set splitright

" QuickFix

  " Auto open quickfix-window when grep
  autocmd QuickFixCmdPost *grep* cwindow


" ============================================================================
"  VISUAL SETTINGS
"
  syntax on

  set guicursor=a:blinkon0
  set colorcolumn=80
  set laststatus =2
  set mousehide
  set number
  set ruler
  set scrolloff  =5
  set showcmd
  set statusline =%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
  set t_Co       =256
  set nolist
  if s:is_mac
    set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
  end


" ============================================================================
"  KEY MAPPING
"
  let mapleader="\<Space>"

  nnoremap <space>, :e $MYVIMRC<cr>

  inoremap jj <ESC>

  nnoremap <space>a ^
  vnoremap <space>a ^
  nnoremap <space>e $
  vnoremap <space>e $

  nnoremap <space>w <c-w>
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-l> <c-w>l

  nnoremap <space>t :tabnew<cr>

  nnoremap <space>[ :cprevious<cr>
  nnoremap <space>] :cnext<cr>

  nnoremap <space>cd :cd %:h<cr>
  nnoremap <space>lcd :cd %:h<cr>

  nnoremap <space>wv <c-w>v
  nnoremap <space>ws <c-w>s

  inoremap ;;now  <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
  inoremap ;;day  <c-r>=strftime("%Y-%m-%d")<cr>
  inoremap ;;time <c-r>=strftime("%H:%M:%S")<cr>


" ============================================================================
"  SETTINGS FOR Windows
"
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
"
  if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Purple guifg=NONE
    set iminsert=0 imsearch=0
  endif


" vim: set ft=vim tabstop=2 :
