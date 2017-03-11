" select tags in visual mode

function! SelectMoveUp()

  execute "normal! gv"

  let l:x = line('.')

  while l:x > 1

   execute "normal! k"
    let l:x -= 1

    let l:y = matchstr(getline(l:x),'<\w\+')
    if l:y != ''
      return 1
    endif

  endwhile

  echo "ERROR: No Start Tag Found!"
  return 0

endfunction
:command! SelectMoveUp :call SelectMoveUp()



function! SelectMoveDown()

  execute "normal! gv"

  let l:x = line('.')
  let l:eof = line('$')

  while l:x < l:eof

   execute "normal! j"
   let l:x += 1

   let l:y = matchstr(getline(l:x),'<\/\w\+')
    if l:y != ''
      return 1
    endif

  endwhile

  return 0

endfunction
:command! SelectMoveDown :call SelectMoveDown()
