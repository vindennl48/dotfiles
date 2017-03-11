
function! EndOfTag()

  let l:x = line('.')
  let l:eof = line('$')
  let l:count = 1

  if matchstr(getline(l:x),'<\w\+') != ''
    let l:x += 1
  else
    echo "ERROR: Cursor Is Not On A Start Tag!"
    return 0
  endif

  while l:x <= l:eof

    if matchstr(getline(l:x),'<\w\+') != ''

     let l:count += 1 

    endif

    if matchstr(getline(l:x),'<\/\w\+>') != ''

      let l:count -= 1      

    endif

    if l:count == 0

      return l:x

    endif

    let l:x += 1

  endwhile

endfunction
