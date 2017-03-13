function! Tabcomplete()
  " save our last spot incase things dont work out
  execute "normal! \<esc>mm"

  " pull current char
  execute "normal! \<c-v>y"
  let l:cur_char=@"

  " if char isnt a space or beginning of line
  if l:cur_char != "" || l:cur_char != " "
    " pull last word
    execute "normal! vby"
    let l:name=@"
    " pull period if there is one
    execute "normal! hvy"
    let l:tempchar=@"
    " if it was a period then we can perform substitution
    if l:tempchar == "."
      " pull first letter to see what should replace
      execute "normal! hvy"
      let l:subtype=@"
      if l:subtype == "f"
        let l:firstline="function! " . l:name . "()\<cr>"
        let l:secondline="  "
        let l:thirdline="endfunction"

        execute "normal! `m"
        execute "normal! vBx"
        execute "normal! a" . l:firstline . l:thirdline . "\<esc>ko\<tab>"
        startinsert!
        return 0
      endif
    endif
  endif
  execute "normal! \<esc>`ma  "
  startinsert!
endfunction


:inoremap <tab> <esc>:call Tabcomplete()<cr>

