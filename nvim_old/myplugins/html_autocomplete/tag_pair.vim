" #### TAG_PAIR ####
" ##################
" if you do something to one tag, 
" it will affect the other

function! TagPair(type, insert_mode)

  if a:type == 'indent'

    SelectTag

    execute "normal! >>\<esc>"

  endif

  if a:type == 'unindent'

    SelectTag

    execute "normal! <<\<esc>"

  endif

  if a:type == 'rename'

    " check to see if there is a legitimate html tag
    let l:tag_name = matchstr(getline('.'),'<\w\+')
    if l:tag_name != ''
      " if there is then remove '<'
      let l:tag_name = substitute(l:tag_name, '<', '', 'g')

      " jump to endtag line
      call cursor(EndOfTag(), 0)

    endif

    " check to see if there is a legitimate html end tag
    if matchstr(getline('.'),'<\/\w\+>') != ''
      " if there is, replace the text
      execute "normal! 0f/lcw" . l:tag_name . "\<esc>"
    else
      " throw an error
      echo "ERROR: No End Tag Found!"
    endif

  endif

  if a:type == 'create_newline'
    
    if matchstr(getline('.'),'<\w\+') != ''

      let l:x = matchstr(getline('.'),'\w\+')

      execute "normal! o</" . l:x . ">\<esc>O\<tab>\<bs>"

    else

      execute "normal! ciw<\<esc>pa>\<esc>o</\<esc>pa>\<esc>O\<tab>\<bs>"

    endif

  endif

  if a:type == 'create'
    
    if matchstr(getline('.'),'<\w\+') != ''

      let l:x = matchstr(getline('.'),'\w\+')

      execute "normal! A</" . l:x . ">\<esc>hF<"
    
    else

      execute "normal! ciw<\<esc>pa></\<esc>pa>\<esc>hF<"

    endif

  endif

  if a:insert_mode == 1
    startinsert
  elseif a:insert_mode == 2
    startinsert!
  endif

endfunction

:command! TagAddIndent :call TagPair('indent', 0)
:command! TagRemoveIndent :call TagPair('unindent', 0)
:command! TagRename :call TagPair('rename', 0)
:command! TagCreateEnd :call TagPair('create', 1)
:command! TagCreateEndNewline :call TagPair('create_newline', 2)

