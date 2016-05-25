"if &guioptions =~# 'M'
"  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
"endif

set guioptions-=T
set guioptions-=m
set guioptions-=e
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions+=M

set showtabline=1

set winaltkeys=menu

highlight Cursor guifg=NONE guibg=Green
highlight CursorIM guifg=NONE guibg=Purple
