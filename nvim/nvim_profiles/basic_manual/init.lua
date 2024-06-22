--[[
When reloading, to install all of the COC packages, you need to make a sim-link
from coc-packages.json to ~/.config/coc/extensions/package.json

Then you need to run npm install in ~/.config/coc/extensions/
]]--

local g    = vim.g
local map  = vim.keymap.set
local set  = vim.opt
local cmd  = vim.cmd
local call = vim.call
local Plug = vim.fn['plug#']

-- Assign Mapleader
g.mapleader = '-' -- Make sure this is first!

-- PLUGINS ---------------------------------------------------------------------
--------------------------------------------------------------------------------
-- cmd('source $HOME/.config/nvim/plugins/vim-plug/plug.vim')
cmd('source $HOME/.local/share/nvim/plugins/vim-plug/plug.vim')
call('plug#begin', '$HOME/.local/share/nvim/plugins')

Plug 'junegunn/vim-plug' -- to make sure vim-plug is not removed
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) -- cool color scheme
Plug 'christoomey/vim-tmux-navigator' -- switch between tmux and vim
Plug 'tmux-plugins/vim-tmux' -- additional tools to deal with tmux
Plug 'tpope/vim-repeat' -- repeat plugin commands
Plug 'junegunn/fzf.vim' -- fuzzy finder
  Plug 'junegunn/fzf' -- dependency
Plug 'scrooloose/nerdtree' -- filetree
Plug 'scrooloose/nerdcommenter' -- easy commenting
Plug 'phaazon/hop.nvim' -- quick jump to another char
Plug 'kwkarlwang/bufresize.nvim' -- keep vim buffers the same sz during term resize
Plug 'jakemason/ouroboros' -- switch between h and c/cpp file pairs
  Plug 'nvim-lua/plenary.nvim' -- dependency of ouroboros
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) -- so plugins can understand code context
Plug 'echasnovski/mini.nvim' -- a plugin manager, see settings file
Plug('lukas-reineke/indent-blankline.nvim', { ['commit'] = '9637670896b68805430e2f72cf5d16be5b97a22a' }) -- colorful indents
-- Plug('neoclide/coc.nvim', { ['do'] = 'yarn install --frozen-lockfile' }) -- code completion
Plug('neoclide/coc.nvim', { ['branch'] = 'release' }) -- code completion
Plug 'stevearc/oil.nvim' -- file explorer
Plug 'Exafunction/codeium.vim' -- AI autocomplete

call('plug#end')
require('plugins_lua') -- plugin settings in lua
cmd('source $HOME/.config/nvim/lua/plugins_vim.vim') -- plugin settings in vimscript
--------------------------------------------------------------------------------
-- END PLUGINS -----------------------------------------------------------------


-- LOCATION SHORTCUTS ----------------------------------------------------------
--------------------------------------------------------------------------------
map("n", "es", ":e ~/.config/nvim/<cr>",                                { noremap = false, desc = "Open vim keymaps" })
map("n", "ea", ":e ~/.oh-my-zsh/custom/general.zsh<cr>",                { noremap = false, desc = "Open bash alias commands" })
map("n", "ee", ":e ~/bin/dotfiles/UserNotes.md<cr>",                    { noremap = false, desc = "Open User Notes" })
map("n", "ef", "::vsp<cr><c-w>l:e ~/bin/dotfiles/shell/helpers.sh<cr>", { noremap = false, desc = "Open shell helpers" })
--------------------------------------------------------------------------------
-- END LOCATION SHORTCUTS ------------------------------------------------------


-- NORMAL MODE -----------------------------------------------------------------
--------------------------------------------------------------------------------
-- Standard remaps
map("n", ";",         ":",       { noremap = false })
map("n", ":",         ";",       { noremap = false })
map("n", "a",         "A",       { noremap = false })
map("n", "d",         "dd",      { noremap = false })
map("n", "J",         "ddp",     { noremap = false })
map("n", "K",         "kddpk",   { noremap = true })
map("n", "H",         "<<",      { noremap = false, silent = true })
map("n", "L",         ">>",      { noremap = false, silent = true })
map("n", "c4",        "c$",      { noremap = false })
map("n", "<leader>s", ":%s /",   { noremap = false, desc = "Search & Replace" })
map("n", "q1",        ":q<cr>",  { noremap = false })

-- FZF
map("n", "<C-p>", ":Files<cr>", { noremap = false, silent = true, desc = "Fuzzy finder" })

-- Split Arrangement
map("n", "<leader>zz", ":wincmd _<cr>:wincmd |<cr>", { noremap = false, silent = true, desc = "Zoom into pane" })
map("n", "<leader>zf", ":wincmd =<cr>",              { noremap = false, silent = true, desc = "Zoom out of pane" })
map("n", "<leader>ze", "<C-w>=",                     { noremap = false, silent = true, desc = "Reset all pane sizes" })

map("n", "<leader>y", ":vsp<cr><c-w>l", { noremap = false, silent = true, desc = "Split pane horizontally" })
map("n", "<leader>x", ":sp<cr><c-w>j",  { noremap = false, silent = true, desc = "Split pane vertically" })

map("n", "<leader>b", ":bn<cr>", { noremap = false, silent = true, desc = "Switch to next buffer" })
map("n", "<leader>v", ":bp<cr>", { noremap = false, silent = true, desc = "Switch to prev buffer" })

map("n", "<leader>zh", "<C-w>H", { noremap = false, silent = true, desc = "Move current split to left max height" })
map("n", "<leader>zj", "<C-w>J", { noremap = false, silent = true, desc = "Move current split to top max height" })
map("n", "<leader>zk", "<C-w>K", { noremap = false, silent = true, desc = "Move current split to bottom max height" })
map("n", "<leader>zl", "<C-w>L", { noremap = false, silent = true, desc = "Move current split to right max height" })
map("n", "<leader>zr", "<C-w>x", { noremap = false, silent = true, desc = "Swap splits with the other child split" })

map("n", "<leader>zv",
  function()
    print("set.winwidth: " .. set.winwidth:get())
    if set.winwidth:get() == 180 then
      set.winwidth  = 1
      set.winheight = 1
      vim.cmd[[wincmd =]]
    else
      set.winwidth  = 180
      set.winheight = 50
    end
  end,
{ noremap = false, silent = false, desc = "Make the active split bigger than the rest" })

-- Move to a different split
map("n", "<C-k>", ":wincmd k<cr>", { noremap = false, silent = true, desc = "move to top split" })
map("n", "<C-j>", ":wincmd j<cr>", { noremap = false, silent = true, desc = "move to bottom split" })
map("n", "<C-h>", ":wincmd h<cr>", { noremap = false, silent = true, desc = "move to left split" })
map("n", "<C-l>", ":wincmd l<cr>", { noremap = false, silent = true, desc = "move to right split" })

-- Custom CWD python app
map(
  "n",
  "<leader>cwd",
  function()
    -- print(vim.fn.expand("%:p:h"))
    local directory = vim.fn.expand("%:p:h")
    os.execute("python3 /Users/mitch/bin/dotfiles/python/CWD.py -a " .. directory)
    print("CWD> Current Working Directory Saved!")
  end,
  {
    noremap = false,
    silent  = true,
    desc    = "Adds the current directory to CWD"
  }
)

-- map(
--   "i",
--   "<leader>cwg",
--   function()
--     os.execute("python3 /Users/mitch/bin/dotfiles/python/CWD.py -d")
--   end,
--   {
--     noremap = false,
--     silent  = true,
--     desc    = "move to right split"
--   }
-- )

-- END NORMAL MODE -------------------------------------------------------------
--------------------------------------------------------------------------------


-- INSERT MODE -----------------------------------------------------------------
--------------------------------------------------------------------------------
map("i", "jk", "<esc><esc>", { noremap = false })
-- END INSERT MODE--------------------------------------------------------------
--------------------------------------------------------------------------------


-- VISUAL MODE -----------------------------------------------------------------
--------------------------------------------------------------------------------
map("v", "H",          "<gv",              { noremap = false })
map("v", "L",          ">gv",              { noremap = false })
map("v", "i",          "I",                { noremap = false })
map("v", "I",          "i",                { noremap = false })
map("v", "J",          ":m '>+1<CR>gv=gv", { noremap = false })
map("v", "K",          ":m '<-2<CR>gv=gv", { noremap = false })
map("v", "<leader>gn", "g<C-a>",           { noremap = false, desc = "Number a vertical list" })
-- END VISUAL MODE -------------------------------------------------------------
--------------------------------------------------------------------------------


-- MULTI MODES -----------------------------------------------------------------
--------------------------------------------------------------------------------
map({ "n", "i", "v" }, "<esc>", "<esc><esc>",          { noremap = false })
map({ "n", "i", "v" }, "<C-z>", "",                    { noremap = false, desc = "Prevents accidental detachment" })
map({ "n", "v" }, "<leader>Y",   '"+y',                { noremap = false, desc = "Copy to System Clipboard" })
map({ "n", "v" }, "<leader>P",   '"+p',                { noremap = false, desc = "Paste from system clipboard (or use ctrl+v)" })
map({ "n", "v" }, "<leader>cop", ":'<,'>w! ~/.cp<cr>", { noremap = false, silent = true, desc = "Copy to temp buffer" })
map({ "n", "v" }, "<leader>pas", ":r ~/.cp<cr>",       { noremap = false, silent = true, desc = "Paste from temp buffer" })
-- END MULTI MODES -------------------------------------------------------------
--------------------------------------------------------------------------------


-- SYSTEM SETTINGS -------------------------------------------------------------
--------------------------------------------------------------------------------
-- line numbers to the left
set.nu = true
set.relativenumber = true
set.scrolloff = 5 -- dont scroll down lower than 5 lines

-- setting up 2 spaces for tabs
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true -- autoindenting

set.wrap = false -- wordwrap

-- stop backups, can have some issues
set.swapfile = false
set.backup = false

set.termguicolors = true -- good colors

set.signcolumn = "yes" -- leave room for widgets in gutter column

set.colorcolumn = "81" -- sets a bar for 80 chars

set.splitbelow = true -- defaults to new splits to the bottom
set.splitright = true -- defaults to new splits to the right

-- search functions
set.incsearch = true -- highlight as we search
set.ignorecase = true -- ignore case during search
set.smartcase = true -- ignores case during search unless a cap is used

set.fsync = true -- should prevent losing data on system crashes

set.mouse = "a" -- allow mouse use
--------------------------------------------------------------------------------
-- END SYSTEM SETTINGS ---------------------------------------------------------
