"" HTML mappings ""

  :nnoremap <silent> <c-w> :HtmlStartOfTag<cr>
  :nnoremap <silent> <c-d> :HtmlEndOfTag<cr>

  :nnoremap <silent> <leader>vt :SelectTag<cr>

  "" Editing Tags
  :nnoremap <leader>mcl :HtmlMetaClass<cr>
  :inoremap <leader>mcl <esc>:HtmlMetaClass<cr>

  :nnoremap <leader>mst :HtmlMetaStyle<cr>
  :inoremap <leader>mst <esc>:HtmlMetaStyle<cr>

  :nnoremap <leader>mid :HtmlMetaId<cr>
  :inoremap <leader>mid <esc>:HtmlMetaId<cr>

  :nnoremap <leader>mhr :HtmlMetaHref<cr>
  :inoremap <leader>mhr <esc>:HtmlMetaHref<cr>

  :nnoremap <leader>ei :TagAddIndent<cr>
  :nnoremap <leader>eu :TagRemoveIndent<cr>
  :nnoremap <leader>er :TagRename<cr>

  :nnoremap <leader>ee :TagCreateEnd<cr>
  :nnoremap <leader>en :TagCreateEndNewline<cr>

  :nnoremap <leader>eo :OpenTag<cr>
  :nnoremap <leader>ec :CloseTag<cr>

  :nnoremap <leader>es :SurroundTag<cr>

