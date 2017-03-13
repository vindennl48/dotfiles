" Find parent html tag

function! FindStartTag(line)
  if matchstr(getline(a:line),'<\w\+') == ''

    if (a:line - 1) <= 0
      return 0
    endif

    let l:start_tag = FindStartTag(a:line - 1)

    if l:start_tag != 0
      return l:start_tag
    else
      return 0
    endif

  else

    return a:line

  endif

endfunction

function! FindParentTag()

  let l:line_num = FindStartTag(line('.')) - 1
  let l:found_tag = 1

  while l:found_tag != 0
  
    if l:line_num == 0
      echo "ERROR: No Parent Tag Found!"
      return 0
    endif

    let l:curline = getline(l:line_num)

    if matchstr(l:curline,'<\/\w\+>') != ''
      let l:found_tag += 1
    elseif matchstr(l:curline,'<\w\+') != ''
      let l:found_tag -= 1
    endif

    let l:line_num -= 1

  endwhile

  let l:line_num += 1
  return l:line_num

endfunction

:command! FindStartTag :echo "Start Tag: " . FindStartTag(line('.'))
:command! FindParentTag :echo "Parent Tag: " . FindParentTag()
