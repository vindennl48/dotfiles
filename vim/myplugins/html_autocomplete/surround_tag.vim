
function! SurroundTag()

  call TagPair('create_newline', 0)

  execute "normal! ddj"

  SelectTag
  
  execute "normal! xkkp"

  TagAddIndent

  execute "normal! k"

endfunction

:command! SurroundTag :call SurroundTag()
