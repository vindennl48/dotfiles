"""" SOURCE ALL THE THINGS """"

  "" Unload all keymaps
  :so $MYVIMPATH/keybindings_options/unmap_all.vim
  :so $MYVIMPATH/keybindings_options/new_maps.vim

  "" Vim Options
  :so $MYVIMPATH/keybindings_options/options.vim
  :so $MYVIMPATH/keybindings_options/html_maps.vim

  "" ctrlP Options
  :so $MYVIMPATH/keybindings_options/ctrlp_options.vim

  "" Leader Key Bindings
  :so $MYVIMPATH/keybindings_options/leader_bindings.vim

  "" Syntax Highlighting
  :au BufNewFile,BufRead *.EXP set filetype=stplc

  "" Personal Plugins
  for f in split(glob('$MYVIMPATH/myplugins/*.vim'), '\n')
    exe 'source' f
  endfor
