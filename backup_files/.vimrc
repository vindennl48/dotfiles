" Remaps
:let mapleader = "-"

" escape
:inoremap jk <Esc>
" easier way to quit without saving
:nnoremap q1 :q!<cr>
" swap colon with semicolon
:nnoremap ; :
:nnoremap : ;
" move current line up or down one line
:nnoremap <C-j> <esc>ddp
:nnoremap <C-k> <esc>ddkkp
" make lowercase a insert at end of line
:nnoremap A a
:nnoremap a A
" indent or unindent line
:nnoremap <Left> <<
:nnoremap <Right> >>
" comment out single line with hash
:nnoremap <leader>c ma0i# <esc>`a
" reload vimrc file
:nnoremap <leader>r :so ~/.vimrc<cr>
" unselect selected text from search
:nnoremap <leader>s :noh<cr>>
" save file
:nnoremap <leader>w :w<cr>

" RAILS ADDITIONS "
" insert <% %> tag
:nnoremap <leader>% i<%  %><esc>2hi
" insert <%= %> tag
:nnoremap <leader>= i<%=  %><esc>2hi
" insert <t></t> tag
:nnoremap <leader>< i<t></t><esc>3hi

"Window Bindings"
":nnoremap <C-J> <C-W><C-J>
":nnoremap <C-K> <C-W><C-K>
":nnoremap <C-L> <C-W><C-L>
":nnoremap <C-H> <C-W><C-H>

"Comment Out Code"
:vnoremap <leader>c I#<esc><esc>

" Search in Vim"
set path+=**

" VimUI
""""""""""""""""""""""""""""""""
nnoremap <leader>n :tabnew<cr>
nnoremap <leader>d :tabclose<cr>
""""""""""""""""""""""""""""""""

" NerdTree
""""""""""""""""""""""""""""""""
execute pathogen#infect()
nnoremap <leader>no :NERDTree<cr>
nnoremap <leader>nt :NERDTreeMirror<cr>
""""""""""""""""""""""""""""""""

" Explanations:
" https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/

" Indent Options
set autoindent
set expandtab
" set filetype indent on
set shiftround
set shiftwidth=2
set smarttab
set tabstop=2

" Search Options
set hlsearch
set ignorecase
set incsearch
set smartcase

" Performance Options
set complete-=i
" set lazyredraw

" Text Rendering Options
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=5
set sidescrolloff=5
syntax enable
set wrap

" User Interface Options
set laststatus=2
set ruler
set wildmenu
" set tabpagemax=50
" :colorscheme wombat256mod
set cursorline
set noerrorbells
set visualbell
set  mouse=a
set title
set background=dark

" Code Folding Options
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" Miscellaneous Options
set autoread
set backspace=indent,eol,start
" set confirm
set history=1000
set nomodeline
"set spell

" set side numbers to show line num in insert mode
set rnu
function! ToggleNumbersOn()
    set rnu!
    set nu
endfunction
function! ToggleRelativeOn()
    set nu!
    set rnu
endfunction
autocmd FocusLost * :call ToggleNumbersOn()
autocmd FocusGained * :call ToggleRelativeOn()
autocmd InsertEnter * :call ToggleNumbersOn()
autocmd InsertLeave * :call ToggleRelativeOn()

:colorscheme desert
:highlight Comment ctermfg=green
:highlight String ctermfg=172
