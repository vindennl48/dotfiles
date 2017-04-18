"""" ANYTHING GOES """"

  :nnoremap <F9> za

  "" leader
  :let mapleader = "-"

  "" semi colon and colon switch
  :nnoremap : ;
  :nnoremap ; :

  "" quit without saving
  :noremap q1 :q!<cr>

  "" esc key
  :inoremap jk <esc>

"""" NORMAL MODE """"

  "" enter insert mode
  :nnoremap i i
  
  "" movement
  :nnoremap h h
  :nnoremap j j
  :nnoremap k k
  :nnoremap l l

  "" go to end of line
  :nnoremap a A
  
  "" yank (copy)
  :nnoremap y y
  :nnoremap yy yy
  
  "" paste
  :nnoremap p p
  
  "" replace char
  :nnoremap r r
  
  "" replace continuous
  :nnoremap R R
  
  "" cut till end of line
  :nnoremap c4 c$
  
  "" cut inside enclosure
  :nnoremap c" ci"
  :nnoremap c' ci'
  :nnoremap c0 ci)
  :nnoremap c] ci]
  :nnoremap c} ci}
  :nnoremap cw ciw
  :nnoremap cn ct <esc>lx
  
  "" cut until
  :nnoremap ct ct
  
  "" undo
  :nnoremap u u
  
  "" redo undo event
  :nnoremap <c-r> <c-r>
  
  "" start new line
  :nnoremap o o
  ":TagIndent<cr>
  :nnoremap O O
  
  "" next word
  :nnoremap w w
  :nnoremap W f l
  
  "" previous word
  :nnoremap b b
  :nnoremap B hF l
  
  "" find on line
  :nnoremap f f
  :nnoremap F F
  
  "" delete line
  :nnoremap d dd
  
  "" delete letter
  :nnoremap x x
  
  "" go to beginning of line
  :nnoremap 0 0
  
  "" line movement
  :nnoremap H <<
  :nnoremap J ddp
  :nnoremap K kddpk
  :nnoremap L >>
  
  "" go to top of page
  :nnoremap gg gg
  
  "" go to bottom of page
  :nnoremap G G
  
  "" shift page to top/mid/bottom
"  :nnoremap z. z.
"  :nnoremap z- z-
"  :nnoremap z<cr> z<cr>

  "" Next search result
  :nnoremap n n

"""" INSERT MODE """"
  :inoremap "" ""<esc>i
  :inoremap '' ''<esc>i
  :inoremap () ()<esc>i
  :inoremap {} {}<esc>i
  :inoremap [] []<esc>i
  :inoremap <> <><esc>i
  ":inoremap """ ""
  ":inoremap ''' ''
  ":inoremap ()) ()
  ":inoremap {}} {}
  ":inoremap []] []
  ":inoremap <>> <>

  :inoremap <c-o> <c-n>

"""" VISUAL MODE """"

  :nnoremap v v
  :nnoremap vt vt
  :nnoremap vT vT
  
  "" enter visual line mode
  :nnoremap V V
  
  "" enter visual any char mode
  :nnoremap <c-v> <c-v>
  
  "" movement
  :vnoremap h h
  :vnoremap j j
  :vnoremap k k
  :vnoremap l l
  
  "" selection movement
  :vnoremap H <gv
  " :vnoremap J xp
  " :vnoremap K kxpk
  :vnoremap L >gv
  
  "" go to top of page
  :vnoremap gg gg
  
  "" go to bottom of page
  :vnoremap G G
  
  "" delete highlighted
  :vnoremap x x
  
  "" yank (copy)
  :vnoremap y y
  
  "" paste
  :vnoremap p p
  
  "" replace
  :vnoremap r r
  
  "" insert text
  :vnoremap i I
  
  "" select word
  :vnoremap w w

  "" select previous word
  :vnoremap b b
