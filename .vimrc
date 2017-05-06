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
  set autoread
  set backspace =indent,eol,start
  set clipboard =unnamed,autoselect
  set history   =100
  set tags      =tags;
  set viminfo   ='1000,f1,:20,/10,%100
  set iminsert  =0
  set imsearch  =-1
  set imdisable
  set wildmode  =longest:full,full
  set nohidden

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
  if s:is_mac
    set fileencodings =utf-8,iso-2022-jp,euc-jp,cp932,sjis,utf16le
  elseif s:is_windows
    set fileencodings =iso-2022-jp,euc-jp,utf-8,cp932,sjis,utf16le
  endif
  "set fileencoding  =utf-8
  "set fileencodings =iso-2022-jp,euc-jp,utf-8,cp932,sjis,utf16le
  "set fileencodings =iso-2022-jp,cp932,sjis,euc-jp,utf-16le,utf-8
  "set bomb
  "set binary
  "set ttyfast

" Searching

  set hls
  set nohlsearch
  set incsearch
  set ignorecase
  set smartcase
  set magic

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
  set colorcolumn=0
  set laststatus =2
  set mousehide
  set number
  set ruler
  set scrolloff  =5
  set showcmd
  set statusline =%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
  set t_Co       =256
  set nolist
  set nocursorline
  hi clear CursorLine
  if s:is_mac
    set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
  end


" ============================================================================
"  KEY MAPPING
"
  let mapleader="\<Space>"

  nnoremap <space>, :e $MYVIMRC<cr>

  inoremap jj <ESC>
  inoremap <ESC> <ESC>:set iminsert=0<cr>

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
  nnoremap <space>E  :Ex<cr>
  nnoremap <space>he :Hex<cr>
  nnoremap <space>ve :Vex<cr>
  nnoremap <space>te :Tex<cr>
  nnoremap <space>rex :Rex<cr>

  nnoremap <space>[ :cprevious<cr>zO
  nnoremap <space>] :cnext<cr>zO

  nnoremap <space>cd :cd %:h<cr>
  nnoremap <space>lcd :lcd %:h<cr>

  nnoremap / /\v
  nnoremap <space>rep :%s///g<left><left>

  inoremap ;;now  <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
  cnoremap ;;now  <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
  inoremap ;;date <c-r>=strftime("%Y-%m-%d")<cr>
  cnoremap ;;date <c-r>=strftime("%Y-%m-%d")<cr>
  inoremap ;;time <c-r>=strftime("%H:%M:%S")<cr>
  cnoremap ;;time <c-r>=strftime("%H:%M:%S")<cr>

  nnoremap <space>rb :w<cr>:!ruby %<cr>

  inoremap ;;img ![img]()<esc>Pa=w740
  "inoremap ;;img ![img]()<esc>P :s/=w\d\{1,4\}-h\d\{1,4\}-no/=w740/<cr>


" ============================================================================
"  Functions
"


" ============================================================================
"  QuickFix
"
  set errorformat=%f\|%l\ col\ %c\|\ %m


" ============================================================================
"  SetFileType
"
  au BufNewFile,BufRead *.mdl,*.frm setf vb


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


" vim:ft=vim ts=2:
