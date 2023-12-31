" Used for switching between header and cpp files easily

" only works in a c/cpp file
autocmd! Filetype h,c,cpp noremap<buffer> <leader>t :Ouroboros<CR>

" open result in a vertical split "" not sure why this fails
" autocmd! Filetype h,c,cpp noremap<buffer> <leader>tv :vsplit \| Ouroboros<CR>
" open result in a horizontal split
" autocmd! Filetype h,c,cpp noremap<buffer> <leader>ty :split \| Ouroboros<CR>
