call plug#begin('~/.local/share/nvim/plugged')
  """" Syntax
    Plug 'mhartington/oceanic-next'         " Syntax Highlighting & theme
    Plug 'pangloss/vim-javascript'          " Javascript syntax highlighting
    Plug 'mxw/vim-jsx'                      " Syntax highlighting for react
    Plug 'junegunn/vim-easy-align'          " Auto align variables
    Plug 'triglav/vim-visual-increment'     " Auto align variables

    " Autocomplete
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
  """" END Syntax

  """" Add-ons
    Plug 'scrooloose/nerdtree'              " File browser
    Plug 'scrooloose/nerdcommenter'         " Commenting tool
    Plug '~/.fzf'                           " Use fuzzy finder
    Plug 'mattn/emmet-vim'                  " Auto-complete syntax
    Plug 'christoomey/vim-tmux-runner'      " Send commands to tmux pane
    Plug 'vimwiki/vimwiki'                  " wiki for vim
    Plug 'mattn/emmet-vim'                  " Emmet linter for html
  """" END Add-ons

  """" Themes and UI
    Plug 'vim-airline/vim-airline'          " Status Bar
    Plug 'Yggdroot/indentLine'              " white-space chars before code
    Plug 'christoomey/vim-tmux-navigator'   " Vim and Tmux interaction
    Plug 'tmux-plugins/vim-tmux'            " Syntax and special funcs for .tmux.conf
    Plug 'ryanoasis/vim-devicons'           " Icon pack for term
  """" END Themes and UI

call plug#end()

set encoding=utf-8

"""" Vimwiki Settings
set nocompatible
filetype plugin on
syntax on
"""" END Vimwiki Settings


" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0

" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

"""" Emmet Vim
  let g:user_emmet_leader_key='<C-e>'
"""" END Emmet Vim

"""" Oceanic Next Plugin
  if (has("termguicolors"))
   set termguicolors
  endif
  
  " Theme
  syntax on
  let g:oceanic_next_terminal_bold=1
  let g:oceanic_next_terminal_italic=1
  colorscheme OceanicNext
  
  " Airline Theme
  let g:airline_theme='oceanicnext'
"""" END Oceanic Next Plugin

"""" Airline Plugin
  "let g:airline_left_sep='▶'
  "let g:airline_right_sep='◀'
  let g:airline_powerline_fonts=1
  let g:airline_detect_paste=1
  let g:airline_inactive_collapse=1
  let g:airline_symbols_ascii=1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#buffer_idx_mode = 1
"""" END Airline Plugin

"""" Indent Line
  let g:indentLine_setColors=0
  let g:indentLine_char='|'
"""" ENDIndent Line

"""" Persona Plugins
  " Got to get these in first so we can remap them
  for f in split(glob('$MYNVIMPATH/myplugins/*.vim'), '\n')
    exe 'source' f
  endfor
"""" END Persona Plugins

"""" Vim Easy Align
  let g:easy_align_ignore_groups = ['Comments']
"""" END Vim Easy Align

"""" Remaps
  :nnoremap ; :
  :nnoremap : ;
  " Jump to end of line
  :nnoremap a A
  :inoremap jk <esc><esc>
  :noremap <esc> <esc><esc>
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
"""" END Remaps

"""" Leader maps
  let mapleader = '-'
  " Copy and paste to external buffer
  :vnoremap <leader>cop :'<,'>w! ~/.cp<cr>
  :nnoremap <leader>pas :r ~/.cp<cr>
  " Playback copied command to repeat
  :nnoremap <leader>g @g
  " Nerdtree
  :nnoremap <leader>n :NERDTreeToggle<cr>
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
  " Ctrl P but with fzf
  :nnoremap <C-p> :FZF<cr>
  " Ctrl P set directory
  ":nnoremap <C-f> :FZF 
  " Ctrl P actions
  let g:fzf_action = {
    \'alt-x': 'split',
    \'alt-y': 'vsplit'}

  " Html + ERB stuff
    " Jump to tag 'class'
    :nnoremap <leader>mc :HtmlMetaClass<cr>
    :inoremap <leader>mc <esc>:HtmlMetaClass<cr>
    " Jump to tag 'style'
    :nnoremap <leader>ms :HtmlMetaStyle<cr>
    :inoremap <leader>ms <esc>:HtmlMetaStyle<cr>
    " Jump to tag 'id'
    :nnoremap <leader>mi :HtmlMetaId<cr>
    :inoremap <leader>mi <esc>:HtmlMetaId<cr>
    " Jump to tag 'href'
    :nnoremap <leader>mh :HtmlMetaHref<cr>
    :inoremap <leader>mh <esc>:HtmlMetaHref<cr>
    " Jump to tag 'type'
    :nnoremap <leader>mt :HtmlMetaType<cr>
    :inoremap <leader>mt <esc>:HtmlMetaType<cr>
    " Create HTML Tags, singleline, multiline
    :nnoremap <leader>ee :TagCreateEnd<cr>
    :nnoremap <leader>en :TagCreateEndNewline<cr>
    " Clear everything in the text area of a tag
    :nnoremap c< F>lct<
    " Clear the tag name
    :nnoremap c> F<lct>
    " Clear comment
    :nnoremap c- F- ct-  <esc>i
    " Add comment at end of tag
    :nnoremap <leader>ec i<!--  --><esc>F i

    " insert <% %> tag
    :inoremap <leader>rr <%  %><esc>2hi
    " insert <%= %> tag
    :inoremap <leader>re <%=  %><esc>2hi
  "

  " Easy Align
    :xmap ga <Plug>(EasyAlign)
    :vnoremap <leader>a;       :EasyAlign *:<cr>
    :vnoremap <leader>a=       :EasyAlign *=<cr>
    :vnoremap <leader>a,       :EasyAlign *,<cr>
    :vnoremap <leader>a<space> :EasyAlign *\ <cr>
  " 

  " Visual Increment
    :vmap <leader>i <Plug>VisualIncrement
    :vmap <leader>d <Plug>VisualDecrement
  "



"""" END Leader maps

"""" System Settings
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

  " User Interface Options
  """"""""""""""""""""""""
    " Allow mouse for scroll
    set mouse=a
    " Allow touch scrolling
    function! MouseScroll()
      "mark b is the current cursor position
      "mark a is the previous cursor position
      norm mb
      let currPos=line('.')
      norm `a
      let prevPos=line('.')
      if currPos>prevPos
        norm `bma
        norm ^E
      elseif currPos<prevPos
        norm `bma
        norm ^Y
      endif
    endfunction

    map <LeftDrag> ma<LeftMouse>:call MouseScroll()<cr>
  """"""""""""""""""""""""


"""" ENDSystem Settings
