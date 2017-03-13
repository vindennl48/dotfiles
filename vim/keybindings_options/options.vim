" Explanations:
" https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/

" Indent Options
""""""""""""""""
  " indent on creation of next line
  set autoindent
  " convert tabs to spaces
  set expandtab
  " when shifting left/right round to nearest
  "  multiple of shiftwidth spaces
  set shiftround
  " set tab spaces
  set shiftwidth=2
  " set tabstop to tabstop num of spaces
  set smarttab
  " set number of spaces for tab
  set tabstop=2
""""""""""""""""

" Search Options
""""""""""""""""
  " enable search highlighting
  set hlsearch
  " ignore case while searching
  set ignorecase
  " incremental search that shows partial matches
  set incsearch
  " auto switch search to case-sensitive
  "  when search query contains a capital
  set smartcase
""""""""""""""""

" Performance Options
"""""""""""""""""""""
  " limit the files searched for auto-complete
  set complete-=i
"""""""""""""""""""""

" Text Rendering Options
""""""""""""""""""""""""
  " encode in utf-8
  set encoding=utf-8
  " avoid wrapping a line in the middle of a word
  set linebreak
  " the num of screen lines to keep above 
  "  and below cursor
  set scrolloff=5
  " num of screen columns to keep to left 
  "  and right of cursor
  set sidescrolloff=5
  " enable syntax highlighting
  syntax enable
  " enable line wrapping
  set wrap
""""""""""""""""""""""""

" User Interface Options
""""""""""""""""""""""""
  " for :find fuzzy finder
  set path+=**
  " always display the status bar
  set laststatus=2
  " always show cursor position
  set ruler
  " display command line's tab complete options as a menu
  set wildmenu
  " highlight bar under cursor
  set cursorline
  " disable beep sounds
  set noerrorbells
  " flash screen when beep sounds
  set visualbell
  " allow mouse for scroll/resize
  set mouse=a
""""""""""""""""""""""

" Code Folding Options
""""""""""""""""""""""
  set foldmethod=indent
  set foldnestmax=10
  set nofoldenable
""""""""""""""""""""""

" Miscellaneous Options
"""""""""""""""""""""""
  " unknown
  set nocompatible
  " auto re-read files if unmodified inside vim
  set autoread
  " backspace over indents eols and start
  set backspace=indent,eol,start
  " swap file directory for vim
"  set dir=~/.cache/vim
  " number of history undo's 
  set history=1000
  " ignore file's mode lines; use vimrc config instead
  set nomodeline
"""""""""""""""""""""""

" Color Scheme
""""""""""""""
  set title
  set background=dark
  colorscheme desert
  hi Comment ctermfg=green
  hi String ctermfg=172
""""""""""""""

" Other
"""""""
  filetype plugin on
"""""""

" set side numbers to show line num in insert mode
""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd FocusLost * :call ToggleNumbersOn()
  autocmd FocusGained * :call ToggleRelativeOn()
  autocmd InsertEnter * :call ToggleNumbersOn()
  autocmd InsertLeave * :call ToggleRelativeOn()
""""""""""""""""""""""""""""""""""""""""""""""""""
" For toggling line numbers on and off
"""""""""""""""""""""""""""""""""""""""
set rnu
function! ToggleNumbersOn()
    set rnu!
    set nu
endfunction
function! ToggleRelativeOn()
    set nu!
    set rnu
endfunction
"""""""""""""""""""""""""""""""""""""""

" settings for white space and tabs
"""""""""""""""""""""""""""""""""""
  let g:indentLine_char = '┆'
  let g:indentLine_leadingSpaceEnabled = 1
  let g:indentLine_leadingSpaceChar = '·'
"""""""""""""""""""""""""""""""""""

" NerdTree Options
""""""""""""""""""
  execute pathogen#infect()
""""""""""""""""""

" automatically rebalance windows on vim resize
:autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
:nnoremap <leader>wz :wincmd _<cr>:wincmd \|<cr>
:nnoremap <leader>wb :wincmd =<cr>


