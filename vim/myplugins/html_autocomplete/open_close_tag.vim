
function! OpenCloseTag(type)

  if a:type == 'open'

    execute "normal! 0f>li\<cr>\<tab>\<esc>f<i\<cr>\<backspace>\<esc>kk"

  elseif a:type == 'close'

    HtmlNextEndTag

    s/^\s*//g

    execute "normal! i\<backspace>\<esc>"

    s/^\s*//g

    execute "normal! i\<backspace>\<esc>"

  endif

endfunction

:command! CloseTag :call OpenCloseTag('close')
:command! OpenTag :call OpenCloseTag('open')
