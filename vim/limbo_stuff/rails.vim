
" SNIPPETS
"#################################################################################

" :inoremap <leader>test <esc>:call MakeBlock("def", "end")<cr>

" insert <% %> tag
:inoremap <leader>5 <%  %><esc>2hi
" insert <%= %> tag
:inoremap <leader>= <%=  %><esc>2hi
" create tag from '<body'
:inoremap <leader>tag ></><esc>F>hvT<yf/pF<i

" create scenario function
:inoremap <leader>sce scenario "successfully" do<cr>end<esc>kf"li
" create feature with scenario
:imap <leader>fea feature "User visits home page" do<cr>end<esc>O<tab>-sce<esc>l
" create def function
:inoremap <leader>def def function<cr>end<esc>kff
" create new controller class
:inoremap <leader>cont class MysController < ApplicationController<cr>end<esc>kfM
" create end tag
:inoremap <leader>end <esc>oend<esc>O<tab>
" make indent in function
:inoremap <leader>ind <esc>o<tab>

" create new require line
:inoremap <leader>req require ""<esc>i

:inoremap <leader>root root to: "controllers#view", only: [:show]<esc>Fc
:inoremap <leader>reso resources :controller, only: [:new]<esc>Fc
:inoremap <leader>cli click_on ""<esc>i
:inoremap <leader>fil fill_in "", with: ""<esc>10hi

:inoremap <leader>exp expect(page).to have_css "", text: ""<esc>10hi

"#################################################################################
