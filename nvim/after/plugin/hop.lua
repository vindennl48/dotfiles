require('hop').setup({
  jump_on_sole_occurrence = true,
  case_insensitive = true,
  uppercase_labels = false,
  multi_windows = true,
})

vim.keymap.set(
  "n",
  "s",
  ":HopChar1<cr>",
  { noremap = false, silent = true, desc = "Activate Hop" }
)
