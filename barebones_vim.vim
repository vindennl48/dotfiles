" Link To Curl
" https://raw.githubusercontent.com/vindennl48/dotfiles/master/barebones_vim.vim

"""" Remaps
  :nnoremap ; :
  :nnoremap : ;
  " Jump to end of line
  :nnoremap a A
  :inoremap jk <esc><esc>
  " Delete line with 1 stroke
  :nnoremap d dd
  " Quit file, but not if dirty
  :noremap  q1 :q<cr>
  " Cut till end of line
  :nnoremap c4 c$
  " Cut inside xx
  :nnoremap c" ci"
  :nnoremap c' ci'
  :nnoremap c) ci)
  :nnoremap c0 ci)
  :nnoremap c} ci}
  :nnoremap c] ci]
  " Cut entire word
  :nnoremap cw ciw
  " Move current line left
  :nnoremap H <<
  " Move current line right
  :nnoremap L >>
  " Move current line down
  :nnoremap J ddp
  " Move current line up
  :nnoremap K kddpk
  " Move block left
  :vnoremap H <gv
  " Move block right
  :vnoremap L >gv
  " Insert text multiline
  :vnoremap i I

  " Surrounds
  :inoremap ""   ""<esc>i
  :inoremap ''   ''<esc>i
  :inoremap ()   ()<esc>i
  :inoremap {}   {}<esc>i
  :inoremap []   []<esc>i
  :inoremap <>   <><esc>i
  :inoremap \|\| \|\|<esc>i

  let mapleader = '-'
  " Copy and paste to external buffer
  :vnoremap <leader>cop :'<,'>w! ~/.cp<cr>
  :nnoremap <leader>pas :r ~/.cp<cr>
  " Playback copied command to repeat
  :nnoremap <leader>g @g

  " Create vim splits
  :nnoremap <leader>y :vsp<cr><c-w>l
  :nnoremap <leader>x :sp<cr><c-w>j
  :nnoremap <leader>L :vertical resize +5<cr>
  :nnoremap <leader>H :vertical resize -5<cr>

  " Zoom a vim pane
  :nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
  :nnoremap <leader>f :wincmd =<cr>
  " Switch to next buffer
  :nnoremap <leader>b :bn<cr>
  :nnoremap <leader>v :bp<cr>

"""" System Settings
  set encoding=utf-8

  " Indent Options
  """"""""""""""""
    " Indent on creation of next line
    set autoindent
    " Convert tabs to spaces
    set expandtab
    " When shifting left/right round
    "  to the nearest multiple of
    "  the 'shiftwidth' param
    set shiftround
    " See shiftround
    set shiftwidth=2
    " Set tab to spaces
    set smarttab
    " Set tab to number of spaces
    set tabstop=2
  """"""""""""""""

  " Search Options
  """"""""""""""""
    " Enable Search Highlighting
    set hlsearch
    " Ignore case while searching
    set ignorecase
    " Incremental search that shows partial matches
    set incsearch
    " Auto switch to case sensitive search when
    "  query contains a capital
    set smartcase
  """"""""""""""""

  " User Interface Options
  """"""""""""""""""""""""
    " Show relative line numbers on left
    set relativenumber
    " Show line number at cursor
    set number
    " Display command line's tab complete options
    "  as a menu
    set wildmenu
    set wildmode=longest:full,full
    " Disable beep sounds
    set noerrorbells
    " Flash screen when beep sounds
    set visualbell
    " Change cursor for mode
    set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    " Prevent text wrapping
    set nowrap
  """"""""""""""""""""""""
