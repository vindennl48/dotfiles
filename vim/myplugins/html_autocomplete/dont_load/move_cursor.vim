" Move Cursor up and down thru xml

function! HtmlMoveUp()
  let l:x = line('.')
  let l:pos = getcurpos()

  while l:x > 0

    let l:x -= 1

    let l:y = matchstr(getline(l:x),'<\w\+')
    if l:y != ''
      call cursor(l:x,l:pos[2])
      return 1
    endif

  endwhile

  return 0

endfunction
:command! HtmlMoveUp :call HtmlMoveUp()

function! HtmlMoveDown()
  let l:x = line('.')
  let l:eof = line('$')
  let l:pos = getcurpos()

  while l:x <= l:eof

    let l:x += 1

    let l:y = matchstr(getline(l:x),'<\w\+')
    if l:y != ''
      call cursor(l:x,l:pos[2])
      return 1
    endif

  endwhile

  return 0

endfunction
:command! HtmlMoveDown :call HtmlMoveDown()

function! HtmlMoveUpEnd()
  let l:x = line('.')
  let l:pos = getcurpos()

  while l:x > 0

    let l:x -= 1

    let l:y = matchstr(getline(l:x),'<\/\w\+')
    if l:y != ''
      call cursor(l:x,l:pos[2])
      return 1
    endif

  endwhile

  return 0

endfunction
:command! HtmlMoveUpEnd :call HtmlMoveUpEnd()

function! HtmlMoveDownEnd()
  let l:x = line('.')
  let l:eof = line('$')
  let l:pos = getcurpos()

  while l:x <= l:eof

    let l:x += 1

    let l:y = matchstr(getline(l:x),'<\/\w\+')
    if l:y != ''
      call cursor(l:x,l:pos[2])
      return 1
    endif

  endwhile

  return 0

endfunction
:command! HtmlMoveDownEnd :call HtmlMoveDownEnd()
