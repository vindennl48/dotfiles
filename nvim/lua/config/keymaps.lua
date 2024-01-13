-- print("==> Hello from lua/config/keymaps.lua")

local set = vim.keymap.set

-- Location Shortcuts
set("n", "es", ":e ~/.config/nvim/<cr>",                 { noremap = false, desc = "Open vim keymaps" })
set("n", "ea", ":e ~/.oh-my-zsh/custom/general.zsh<cr>", { noremap = false, desc = "Open bash alias commands" })
set("n", "ee", ":e ~/bin/dotfiles/UserNotes.md<cr>",     { noremap = false, desc = "Open User Notes" })


-- NORMAL MODE -----------------------------------------------------------------
--------------------------------------------------------------------------------
-- Standard remaps
set("n", ";",         ":",      { noremap = false })
set("n", ":",         ";",      { noremap = false })
set("n", "a",         "A",      { noremap = false })
set("n", "d",         "dd",     { noremap = false })
set("n", "J",         "ddp",    { noremap = false })
set("n", "K",         "kddpk",  { noremap = true })
set("n", "H",         "<<",     { noremap = false, silent = true })
set("n", "L",         ">>",     { noremap = false, silent = true })
set("n", "c4",        "c$",     { noremap = false })
set("n", "<leader>s", ":%s /",  { noremap = false, desc = "Search & Replace" })
set("n", "q1",        ":q<cr>", { noremap = false })

-- Split Arrangement
set("n", "<leader>zz", ":wincmd _<cr>:wincmd |<cr>", { noremap = false, silent = true, desc = "Zoom into pane" })
set("n", "<leader>zf", ":wincmd =<cr>",              { noremap = false, silent = true, desc = "Zoom out of pane" })
set("n", "<leader>ze", "<C-w>=",                     { noremap = false, silent = true, desc = "Reset all pane sizes" })

set("n", "<leader>y", ":vsp<cr><c-w>l", { noremap = false, silent = true, desc = "Split pane horizontally" })
set("n", "<leader>x", ":sp<cr><c-w>j",  { noremap = false, silent = true, desc = "Split pane vertically" })

set("n", "<leader>b", ":bn<cr>", { noremap = false, silent = true, desc = "Switch to next buffer" })
set("n", "<leader>v", ":bp<cr>", { noremap = false, silent = true, desc = "Switch to prev buffer" })

set("n", "<leader>zh", "<C-w>H", { noremap = false, silent = true, desc = "Move current split to left max height" })
set("n", "<leader>zj", "<C-w>J", { noremap = false, silent = true, desc = "Move current split to top max height" })
set("n", "<leader>zk", "<C-w>K", { noremap = false, silent = true, desc = "Move current split to bottom max height" })
set("n", "<leader>zl", "<C-w>L", { noremap = false, silent = true, desc = "Move current split to right max height" })
set("n", "<leader>zr", "<C-w>x", { noremap = false, silent = true, desc = "Swap splits with the other child split" })

set("n", "<leader>zv",
  function()
    print("vim.opt.winwidth: " .. vim.opt.winwidth:get())
    if vim.opt.winwidth:get() == 180 then
      vim.opt.winwidth  = 1
      vim.opt.winheight = 1
      vim.cmd[[wincmd =]]
    else
      vim.opt.winwidth  = 180
      vim.opt.winheight = 50
    end
  end,
{ noremap = false, silent = false, desc = "Make the active split bigger than the rest" })

-- Move to a different split
-- set("n", "<C-k>", ":wincmd k<cr>", { noremap = false, silent = true, desc = "move to top split" })
-- set("n", "<C-j>", ":wincmd j<cr>", { noremap = false, silent = true, desc = "move to bottom split" })
-- set("n", "<C-h>", ":wincmd h<cr>", { noremap = false, silent = true, desc = "move to left split" })
-- set("n", "<C-l>", ":wincmd l<cr>", { noremap = false, silent = true, desc = "move to right split" })

-- Custom CWD python app
set(
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
    desc    = "move to right split"
  }
)

-- set(
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
set("i", "jk", "<esc><esc>", { noremap = false })
-- END INSERT MODE--------------------------------------------------------------
--------------------------------------------------------------------------------


-- VISUAL MODE -----------------------------------------------------------------
--------------------------------------------------------------------------------
set("v", "H",          "<gv",              { noremap = false })
set("v", "L",          ">gv",              { noremap = false })
set("v", "i",          "I",                { noremap = false })
set("v", "I",          "i",                { noremap = false })
set("v", "J",          ":m '>+1<CR>gv=gv", { noremap = false })
set("v", "K",          ":m '<-2<CR>gv=gv", { noremap = false })
set("v", "<leader>gn", "g<C-a>",           { noremap = false, desc = "Number a vertical list" })
-- END VISUAL MODE -------------------------------------------------------------
--------------------------------------------------------------------------------


-- MULTI MODES -----------------------------------------------------------------
--------------------------------------------------------------------------------
set({ "n", "i", "v" }, "<esc>", "<esc><esc>", { noremap = false })
set({ "n", "i", "v" }, "<C-z>", "",           { noremap = false })
set({ "n", "v" }, "<leader>Y",   '"+y',                { noremap = false, desc = "Copy to System Clipboard" })
set({ "n", "v" }, "<leader>cop", ":'<,'>w! ~/.cp<cr>", { noremap = false, silent = true, desc = "Copy to temp buffer" })
set({ "n", "v" }, "<leader>pas", ":r ~/.cp<cr>",       { noremap = false, silent = true, desc = "Paste from temp buffer" })
-- END MULTI MODES -------------------------------------------------------------
--------------------------------------------------------------------------------
