" Move Cursor up and down thru xml

function! HtmlMove(type)
  if a:type == 'previous_tag'
    ?^\s*<\w\+
  elseif a:type == 'next_tag'
    /^\s*<\w\+
  elseif a:type == 'previous_end_tag'
    ?^\s*<\/\w\+>$
  elseif a:type == 'next_end_tag'
    /^\s*<\/\w\+>$
  endif

  if a:type == 'this_end_tag'
    let l:eot = EndOfTag()
    call cursor(l:eot,1)
    execute "normal! f<"
  elseif a:type == 'this_start_tag'
    let l:sot = StartOfTag()
    call cursor(l:sot,1)
    execute "normal! f<"
  endif

endfunction

:command! HtmlPreviousTag :call HtmlMove('previous_tag')
:command! HtmlNextTag :call HtmlMove('next_tag')
:command! HtmlPreviousEndTag :call HtmlMove('previous_end_tag')
:command! HtmlNextEndTag :call HtmlMove('next_end_tag')

:command! HtmlStartOfTag :call HtmlMove('this_start_tag')
:command! HtmlEndOfTag :call HtmlMove('this_end_tag')
