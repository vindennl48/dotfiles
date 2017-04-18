function! SelectTag()

  let l:eot = ParseTillEnd()

  if l:eot != 0

    let l:lines_away = l:eot - line('.')

    execute "normal! V" . l:lines_away . "j"

    return 1

  endif

  return 0

endfunction

:command! SelectTag :call SelectTag()
