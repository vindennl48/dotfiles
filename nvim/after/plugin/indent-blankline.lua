vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#333333 gui=nocombine]]

vim.cmd [[highlight IndentBlanklineContext1 guifg=#670e6e gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContext2 guifg=#166e0e gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContext3 guifg=#c2b727 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContext4 guifg=#c22727 gui=nocombine]]

-- commented? 
-- vim.cmd [[highlight IndentBlanklineContextStart guifg=#670e6e gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextChar guifg=#670e6e gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineContextSpaceChar guifg=#670e6e gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  char = "¦",
  context_char = "¦",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  context_highlight_list = {
    "IndentBlanklineContext1",
    "IndentBlanklineContext2",
    "IndentBlanklineContext3",
    "IndentBlanklineContext4",
  },
  show_trailing_blankline_indent = true,

  -- char_blankline = "⋅",
  -- space_char_blankline = "⋅",
  show_current_context = true,
  show_current_context_start = true,
}
