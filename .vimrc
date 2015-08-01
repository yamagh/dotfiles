" Color theme
colorscheme molokai
"colorscheme vividchalk 

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" インクレメンタルサーチ
set backspace=indent,eol,start		" allow backspacing over everything in insert mode
set nobackup		" バックアップをしない
set nowritebackup	" バックアップファイルを作らない
set noswapfile		" .swapファイルを作らない
set number		" 行番号
set encoding=utf8
set scrolloff=5		" スクロールする時に下が見えるようにする:w
set guicursor=a:blinkon0		" Disable cursol blink
set clipboard=unnamed,autoselect	" ClipBoard integration with OS X
set list		" 不可視文字
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <ESC>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot
inoremap <C-U> <C-G>u<C-U>
" Execute Ruby
nnoremap <C-e> :!ruby %

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



" # Neobundle #################################################################

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'grep.vim'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes': 'ruby',
  \ }}

" .や::を入力したときにオムニ補完が有効になるようにする
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" 環境変数RSENSE_HOMEに'/usr/local/bin/rsense'を指定しても動く
let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'


call neobundle#end()
filetype plugin indent on
NeoBundleCheck


hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey



