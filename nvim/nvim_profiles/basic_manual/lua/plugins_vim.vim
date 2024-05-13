" Plugin Settings in Vimscript


"" Ouroboros
autocmd! Filetype h,c,cpp noremap<buffer> <leader>t :Ouroboros<CR>


"" Coc Completion
" Included packages for COC
let g:coc_global_extensions = ['coc-pyright', 'coc-json', 'coc-sumneko-lua']
" Some LSP's can have issues with backups
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <C-n> 
      \ coc#pum#visible() ? coc#pum#next(1) : "<C-n>"
      " \ CheckBackspace() ? "<C-n>" :
      " \ coc#refresh()
inoremap <expr> <C-u> coc#pum#visible() ? coc#pum#prev(1) : "<C-u>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "<TAB>"
                              " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> <C-k> :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

