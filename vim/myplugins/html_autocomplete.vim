"""" HTML Autocomplete """"
  "" Source All The Things
  for f in split(glob('$MYVIMPATH/myplugins/html_autocomplete/*.vim'), '\n')
    exe 'source' f
  endfor
