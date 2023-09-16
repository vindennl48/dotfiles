"""" Meta Editor """"

  function! MetaEdit(metatag, nested)
    if a:nested == 0
      let b:this_pos = getpos('.')
    endif
    let b:this_line = getline('.')
    let b:metatag_full = a:metatag . "=\""
    let b:x=matchstr(b:this_line,b:metatag_full)

    " if current line doesnt have a metatag
    if b:x == ''
      " if we find a begin tag, insert metatag
      if matchstr(b:this_line,'^\s*<\w\+') != ''
        execute "normal! 0f>i " . b:metatag_full . "  \"\<esc>h"
        startinsert
      else
        " if we cant find a tag match, keep going up
        "  a row until we do.  if we never do, then
        "  echo out error string.
        if line('.') > 1
          execute "normal! k"
          let b:result = MetaEdit(a:metatag, 1)
        else
          let b:result = 0
        endif
        if b:result == 0
          if a:nested == 0
            let b:func = cursor(b:this_pos[1],b:this_pos[2])
            echo "No Valid HTML Tag To Add \"" . a:metatag . "\" To!"
          endif
          return 0
        else
          return 1
        endif
      endif
    " if the current line already has metatag, then
    "  insert cursor at end of tag
    else
      let b:y=match(b:this_line,b:metatag_full)
      let b:cpos=getcurpos()
      let b:col = b:y + strlen(b:metatag_full)
      echo "col num= " . b:col
      let b:func = cursor(b:cpos[1],b:col)
      execute "normal! f\""
      startinsert
    endif
    return 1
  endfunction
  :command! HtmlMetaClass :call MetaEdit('class', 0)
  :command! HtmlMetaStyle :call MetaEdit('style', 0)
  :command! HtmlMetaId :call MetaEdit('id', 0)
  :command! HtmlMetaHref :call MetaEdit('href', 0)
  :command! HtmlMetaType :call MetaEdit('type', 0)
