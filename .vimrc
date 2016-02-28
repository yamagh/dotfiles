"scriptencoding utf8

if has('vim_starting')
  " Use Vim settings
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

" NeoBundle Path

  if s:is_windows
    let $DOTVIM = expand('~/vimfiles')
  else
    let $DOTVIM = expand('~/.vim')
  endif
  let $VIMBUNDLE = $DOTVIM . '/bundle'
  let $NEOBUNDLEPATH = $VIMBUNDLE . '/neobundle.vim'

" Other

  let mapleader="\<Space>"


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

" Color Scheme

  NeoBundle 'tomasr/molokai'
  "NeoBundle 'nanotech/jellybeans.vim'

" HTML/CSS

  NeoBundleLazy 'mattn/emmet-vim', {
              \   'autoload' : { 
              \     'filetypes' : ['htm', 'html', 'erb'] 
              \   }
              \ }
  NeoBundleLazy 'slim-template/vim-slim', {
              \   'autoload' : { 
              \     'filetypes' : ['slim'] 
              \   }
              \ }

" General

  NeoBundleLazy 'scrooloose/nerdtree', {
              \   'autoload' : {
              \     'commands' : 'NERDTree' 
              \   }
              \ }
  NeoBundleLazy 'Shougo/unite.vim', {
              \   'autoload' : {
              \     'commands' : [ "Unite" ]
              \   }
              \ }
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/vimproc', {
          \   'build' : {
          \     'mac' : 'make -f make_mac.mak',
          \     'unix' : 'make -f make_unix.mak',
          \   }
          \ }
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/neco-syntax'
  NeoBundle 'Townk/vim-autoclose'
  NeoBundle 'xolox/vim-misc'
  NeoBundle 'xolox/vim-session', {
          \   'depends' : 'xolox/vim-misc'
          \ }
  NeoBundle 'Shougo/neocomplete.vim'
  "NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 
  "            \   'autoload' : {
  "            \     'insert' : 1,
  "            \     'filetypes': 'ruby'
  "            \   }
  "            \ }
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'wakatime/vim-wakatime'
  NeoBundleLazy 'thinca/vim-quickrun', {
              \   'autoload' : {
              \     'mappings' : '<Plug>(quickrun',
              \     'commands' : ['QuickRun']
              \   }
              \ }
  NeoBundleLazy 'Lokaltog/vim-easymotion', {
              \   'autoload' : {
              \     'mappings' : '<Plug>(easymotion-' 
              \   }
              \ }
  "NeoBundle 'vim-scripts/dbext.vim'
  "NeoBundle 'Kuniwak/vint'

" NeoBundle ENj }}}

  call neobundle#end()
  filetype plugin indent on
  NeoBundleCheck


" ============================================================================
"  PLUGIN SETTINGS

" Vim-Session

  if neobundle#tap('vim-session')
    call neobundle#config({
       \ 'autoload' : {
       \     'commands' : ['OpenSession', 'SaveSession', 'DeleteSession, CloseSession']
       \   }
       \ })
    "let s:bundle = neobundle#get("vim-session")
    "function! s:bundle.hooks.on_source(bundle)
      let g:session_directory = "~/.vim/session"
      let g:session_autoload = 'yes'
      let g:session_autosave = 'yes'
      let g:session_command_aliases = 1
    "endfunction
    "unlet s:bundle
  
    nnoremap <leader>so :OpenSession
    nnoremap <leader>ss :SaveSession
    nnoremap <leader>sd :DeleteSession<CR>
    nnoremap <leader>sc :CloseSession<CR>

    call neobundle#untap()
  endif

" Unite

  if neobundle#tap('unite.vim')
    "let s:bundle = neobundle#get("unite.vim")
    "function! s:bundle.hooks.on_source(bundle)
      let g:unite_enable_start_insert=1
      let g:unite_source_history_yank_enable =1
      let g:unite_source_file_mru_limit = 200
      call unite#custom_default_action('file', 'tabopen')
    "endfunction
    "unlet s:bundle
    
    nnoremap <silent> <space>uf :Unite<space>file_rec<CR>
    nnoremap <silent> <space>ur :Unite<space>neomru/file<CR>

    call neobundle#untap()
  endif

" NeoComplete

  if neobundle#tap('neocomplete.vim')
    "call neobundle#config({
    "   \   'depends': ['Shougo/context_filetype.vim', 'ujihisa/neco-look', 'pocke/neco-gh-issues', 'Shougo/neco-syntax'],
    "   \ })

    " 起動時に有効化
    let g:neocomplete#enable_at_startup = 1
    " 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " _(アンダースコア)区切りの補完を有効化
    let g:neocomplete#enable_underbar_completion = 1
    let g:neocomplete#enable_camel_case_completion  =  1
    " ポップアップメニューで表示される候補の数
    let g:neocomplete#max_list = 20
    " シンタックスをキャッシュするときの最小文字長
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " 補完を表示する最小文字数
    let g:neocomplete#auto_completion_start_length = 2
    " preview window を閉じない
    let g:neocomplete#enable_auto_close_preview = 0
    AutoCmd InsertLeave * silent! pclose!

    let g:neocomplete#max_keyword_width = 10000

    if !exists('g:neocomplete#delimiter_patterns')
      let g:neocomplete#delimiter_patterns= {}
    endif
    let g:neocomplete#delimiter_patterns.ruby = ['::']

    if !exists('g:neocomplete#same_filetypes')
      let g:neocomplete#same_filetypes = {}
    endif
    let g:neocomplete#same_filetypes.ruby = 'eruby'


    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.typescript = '[^. \t]\.\%(\h\w*\)\?' " Same as JavaScript
    let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\%(\h\w*\)\?'         " Same as JavaScript

    let s:neco_dicts_dir = $HOME . '/.vim/dicts'
    if isdirectory(s:neco_dicts_dir)
      let g:neocomplete#sources#dictionary#dictionaries = {
      \   'ruby': s:neco_dicts_dir . '/ruby.dict',
      \   'javascript': s:neco_dicts_dir . '/jquery.dict',
      \ }
    endif
    let g:neocomplete#data_directory = $HOME . '/.vim/cache/neocomplete'

    call neocomplete#custom#source('look', 'min_pattern_length', 1)

    call neobundle#untap()
  end

" NeoSnippets

  if neobundle#tap('neosnippet')
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    
    " SuperTab like snippets behavior.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    
    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    let g:neosnippet#snippets_directory='~/snippets'

    call neobundle#untap()
  end
    
" EasyMotion
  
  if neobundle#tap('vim-easymotion')
    let s:bundle = neobundle#get("vim-easymotion")
    function! s:bundle.hooks.on_source(bundle)
      let g:EasyMotion_do_mapping = 0
      " Turn on case sensitive feature
      let g:EasyMotion_smartcase = 1
      " keep cursor column with `JK` motions
      let g:EasyMotion_startofline = 0
      " General Configuration
      let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
      " Show target key with upper case to improve readability
      let g:EasyMotion_use_upper = 1
      " Jump to first match with enter & space
      let g:EasyMotion_enter_jump_first = 1
      let g:EasyMotion_space_jump_first = 1
    endfunction
    unlet s:bundle
    
    " Find Motions
    nmap <Leader>f <Plug>(easymotion-s2)
    xmap <Leader>f <Plug>(easymotion-s2)
    omap <Leader>f <Plug>(easymotion-s2)
    " Line Motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    " Search Motions
    " Extend search motions with vital-over command line interface
    " Incremental highlight of all the matches
    " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
    " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
    " :h easymotion-command-line
    nmap g/ <Plug>(easymotion-sn)
    xmap g/ <Plug>(easymotion-sn)
    omap g/ <Plug>(easymotion-tn)

    call neobundle#untap()
  end


" quickrun

  if neobundle#tap('vim-quickrun')
    let g:quickrun_config = {
      \   "_" : {
      \     "outputter/buffer/split" : ":botright 8sp",
      \     "runner" : "vimproc",
      \     "runner/vimproc/updatetime" : 40,
      \   }
      \ }
    nmap <space>rr <Plug>(quickrun)
    "nmap <space>rl <Plug>(quickrun-op)

    call neobundle#untap()
  end

" vim-indent-guides

  if neobundle#tap('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_start_level=2
    let g:indent_guides_auto_colors=0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
    let g:indent_guides_color_change_percent = 30
    let g:indent_guides_guide_size = 1

    call neobundle#untap()
  end


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
  set noundofile
  set tags=tags;
  
  " EOL
  "set nofixeol
  
  " ClipBoard integration with OS X
  set clipboard=unnamed,autoselect

  set splitbelow
  set splitright

" ============================================================================
"  VISUAL SETTINGS

  syntax on
  
  " Disable cursol blink
  set guicursor=a:blinkon0
  
  set colorcolumn=80
  set history=100
  "set list
  set nolist
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

  nnoremap <space>, :tabnew<space>~/.vimrc<cr>
  inoremap jj <ESC>
  nnoremap s <c-w>
  nnoremap <space>t :tabnew<cr>
  nnoremap <space>h ^
  nnoremap <space>l $
  
  " CTRL-U in insert mode deletes a lot
  inoremap <C-U> <C-G>u<C-U>
  
  " Better search
  nnoremap <space>rep :%s///g<left><left>
  nmap / /\v
  nmap <silent> <Esc><Esc> :nohlsearch<CR>
  
  " Search and jump then movo to center
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz
  
  " Change current directory
  nnoremap <silent> <space>lcd :lcd<space>%:h<CR>
  nnoremap <silent> <space>cd :cd<space>%:h<CR>
  
  " Don't use Ex mode, use Q for formatting
  map Q gq

  inoremap ;;now  <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
  inoremap ;;day  <c-r>=strftime("%Y-%m-%d")<cr>
  inoremap ;;time <c-r>=strftime("%H:%M:%S")<cr>
  
  " Show diff between current buffer and before editing
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  		  \ | wincmd p | diffthis
  endif


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

