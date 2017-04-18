
function! Parse_Line(curline, direction)
  let s:mylist = a:curline

  let s:temp = ""
  let s:count = 0

  for s:item in split(s:mylist, '\zs')
    let s:temp = s:temp . s:item

    if matchstr(s:temp, '<!') != '' ||
     \ matchstr(s:temp, '<input') != '' ||
     \ matchstr(s:temp, '<meta') != '' ||
     \ matchstr(s:temp, '<br') != '' ||
     \ matchstr(s:temp, '<link') != ''

      let s:temp = ""

    elseif matchstr(s:temp, '<\w\+[ >]') != ''

      if a:direction == "down"
        let s:count += 1
      elseif a:direction == "up"
        let s:count -= 1
      endif
      let s:temp = ""

    elseif matchstr(s:temp, '<\/\w\+[ >]') != ''

      if a:direction == "down"
        let s:count -= 1
      elseif a:direction == "up"
        let s:count += 1
      endif
      let s:temp = ""

    endif
    
  endfor

  return s:count

endfunction


function! ParseTillEnd()

  let s:linenum = line('.')
  let s:eof = line('$')
  let s:tag_count = 0

  let s:tag_count += Parse_Line(getline(s:linenum), "down")

  while s:tag_count > 0

    let s:linenum += 1
    if s:linenum > s:eof
      return 0
    endif

    let s:tag_count += Parse_Line(getline(s:linenum), "down")

  endwhile

  return s:linenum
  " call cursor(s:linenum, 0)

endfunction

function! ParseTillStart()

  let s:linenum = line('.')
  let s:eof = 0
  let s:tag_count = 0

  let s:tag_count += Parse_Line(getline(s:linenum), "up")

  while s:tag_count > 0

    let s:linenum -= 1
    if s:linenum < s:eof
      return 0
    endif

    let s:tag_count += Parse_Line(getline(s:linenum), "up")

  endwhile

  return s:linenum
  " call cursor(s:linenum, 0)

endfunction

