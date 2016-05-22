if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif
