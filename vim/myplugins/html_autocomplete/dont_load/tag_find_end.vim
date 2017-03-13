" Find end html tag

function! FindEndTag()

  let l:found_tag = 0
  let l:line_num = line('.')
  let l:last_line = line('$')

  if matchstr(getline('.'),'<\w\+') == ''
    let l:tag_count = 1
  else
    let l:tag_count = 0
  endif

  while l:found_tag == 0

    let l:str_line = getline(l:line_num)

    if matchstr(l:str_line,'<\w\+') != ''
      let l:tag_count += 1
    elseif matchstr(l:str_line,'<\/\w\+>') != ''
      let l:tag_count -= 1
    endif

    if l:tag_count == 0
      let l:found_tag = 1
    else
      let l:line_num += 1
    endif

    if l:line_num > l:last_line
      break
    endif

  endwhile

  if l:found_tag == 1
    " echo "Line Number: " . l:line_num
    return l:line_num
  else
    " no valid tag was found
    " echo "ERROR: No Valid Tag Was Found!"
    return 0
  endif

endfunction

:command! FindEndTag :call FindEndTag()
