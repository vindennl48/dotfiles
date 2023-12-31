-- print("==> Hello from lua/config/options.lua")

local set = vim.opt

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
