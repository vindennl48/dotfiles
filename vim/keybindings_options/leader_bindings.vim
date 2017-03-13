"""" LEADER KEYBINDINGS """"

  "" copy and paste to external buffer
  :vnoremap <leader>cop :'<,'>w! ~/.cp<cr>
  :nnoremap <leader>pas :r ~/.cp<cr>

  "" Open NerdTree
  :nnoremap <leader>nerd :NERDTree<cr>

  "" Open :find
  :nnoremap <leader>ff :find<space>

  "" Switch Vim Splits
  :nnoremap <leader>wh <c-w>h
  :nnoremap <leader>wl <c-w>l
  :nnoremap <leader>wj <c-w>j
  :nnoremap <leader>wk <c-w>k
  
  "" Create vim splits
  :nnoremap <leader>wy :vsp<cr><c-w>l
  :nnoremap <leader>wx :sp<cr><c-w>j

  :nnoremap <leader>r :so $MYVIMPATH/source_me.vim<cr>

"""" Rails """"
  "" Open rails find
  :nnoremap <leader>fm :Emodel<space>
  :nnoremap <leader>fv :Eview<space>
  :nnoremap <leader>fc :Econtroller<space>
  :nnoremap <leader>fr :find routes.rb<cr>
  :nnoremap <leader>fs :find schema.rb<cr>

