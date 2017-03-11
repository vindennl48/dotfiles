
" Switch status bar color by mode
"""""""""""""""""""""""""""""""""
" Set color for insert mode
function! SetStatusColorInsert()
  :hi StatusLine ctermbg=black ctermfg=green
endfunction

" Set color back to default
function! SetStatusColorDefault()
  if !exists("w:current_stat_line_color")
    let w:current_stat_line_color = ":hi StatusLine ctermbg=black ctermfg=white"
  endif
  exec w:current_stat_line_color
endfunction

" Set the default color
if !exists("w:current_stat_line_color")
  call SetStatusColorDefault()
endif

"""""""""""""""""""""""""""""""""
" Switch status bar color by mode
"""""""""""""""""""""""""""""""""
autocmd InsertEnter * :call SetStatusColorInsert()
autocmd InsertLeave * :call SetStatusColorDefault()
"""""""""""""""""""""""""""""""""
