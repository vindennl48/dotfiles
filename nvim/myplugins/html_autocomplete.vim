"""" HTML Autocomplete """"
  "" Source All The Things
  for f in split(glob('$MYNVIMPATH/myplugins/html_autocomplete/*.vim'), '\n')
    exe 'source' f
  endfor
