"""" SNIPPETS """"
  :inoremap <leader>rr <%  %><esc>2hi
  :inoremap <leader>re <%=  %><esc>2hi

  :inoremap <leader>rli <%= link_to "Click Me", somewhere_path, class: "btn btn-info" %><esc>FC

  " Clear everything in the text area of a tag
  :nnoremap c< F>lct<
  " Clear the tag name
  :nnoremap c> F<lct>

  " Add comment at end of tag
  :nnoremap <leader>ea F>li <!-- <esc>A --><esc>
