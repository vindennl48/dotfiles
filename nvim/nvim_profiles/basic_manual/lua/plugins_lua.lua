local g    = vim.g
local map  = vim.keymap.set
local set  = vim.opt
local cmd  = vim.cmd
local call = vim.call

-- PLUGIN SETTINGS -------------------------------------------------------------
--------------------------------------------------------------------------------
-- Catppuccin
cmd.colorscheme "catppuccin"

-- NerdTree
map("n", "<leader>n", ":NERDTreeToggle<cr>", { noremap = false, desc = "Open NerdTree" })

-- NerdCommenter
-- g.NERDCreateDefaultMappings = 0 -- Create default mappings
g.NERDSpaceDelims = 1 -- Add spaces after comment delimiters by default
g.NERDRemoveExtraSpaces = 1 -- Remove any extra spaces
-- g.NERDCompactSexyComs = 1 -- Use compact syntax for prettified multi-line comments
g.NERDDefaultAlign = 'left' -- Align line-wise comment delimiters flush left instead of following code indentation
-- g.NERDAltDelims_java = 1 -- Set a language to use its alternate delimiters by default
g.NERDCustomDelimiters = { ['c'] = { ['left']='//' }, ['arduino'] = { ['left']='//' } } -- Add your own custom formats or override the defaults
g.NERDCommentEmptyLines = 1 -- Allow commenting and inverting empty lines (useful when commenting a region)
g.NERDTrimTrailingWhitespace = 1 -- Enable trimming of trailing whitespace when uncommenting
-- g.NERDToggleCheckAllLines = 1 -- Enable NERDCommenterToggle to check all selected lines is commented or not

-- Hop
require('hop').setup({
  jump_on_sole_occurrence = true,
  case_insensitive = true,
  uppercase_labels = false,
  multi_windows = true,
})
vim.keymap.set("n", "s", ":HopChar1<cr>", { noremap = false, silent = true, desc = "Activate Hop" })

-- Bufresize
require("bufresize").setup({
    register = {
        trigger_events = { "BufWinEnter", "WinEnter" },
    },
    resize = {
        keys = {},
        trigger_events = { "VimResized" },
        increment = false,
    },
})

-- Ouroboros
-- cmd("autocmd! Filetype h,c,cpp noremap<buffer> <leader>t :Ouroboros<CR>")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "vim", "vimdoc", "query", "python",
    "bash", "cmake", "comment", "cpp", "css", "csv",
    "git_config", "git_rebase", "gitcommit", "gitignore",
    "gitattributes", "gpg", "html", "java", "javascript",
    "json", "json5", "JSON with comments",
    "lua", "luadoc", "make",
    "ruby", "scss", "sql", "ssh_config", "xml", "yaml",
  },

  ignore_install = {
    "json5", "JSON with comments",
  },

  sync_install = true,

  auto_install = true,

  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Mini
require('mini.cursorword').setup()
require('mini.align').setup()
-- require('mini.tabline').setup()
require('mini.splitjoin').setup({
  mappings = {
    toggle = 'gs'
  }
})

-- Indent Blankline
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

-- Oil.nvim
require("oil").setup({
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    -- ["<C-s>"] = "actions.select_vsplit",
    -- ["<C-h>"] = "actions.select_split",
    -- ["<C-t>"] = "actions.select_tab",
    -- ["<C-p>"] = "actions.preview",
    -- ["<C-c>"] = "actions.close",
    -- ["<C-l>"] = "actions.refresh",
    ["<BS>"] = "actions.parent",
    -- ["_"] = "actions.open_cwd",
    -- ["`"] = "actions.cd",
    -- ["~"] = "actions.tcd",
    -- ["gs"] = "actions.change_sort",
    -- ["gx"] = "actions.open_external",
    -- ["g."] = "actions.toggle_hidden",
    -- ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
})

-- Codeium
g.codeium_disable_bindings = 1
map('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
map('i', '<C-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
map('i', '<C-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
map('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
--------------------------------------------------------------------------------
-- END PLUGIN SETTINGS ---------------------------------------------------------
