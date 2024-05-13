-- print("==> Hello from init.lua")

--[[
When reloading, to install all of the COC packages, you need to make a sim-link
from coc-packages.json to ~/.config/coc/extensions/package.json

Then you need to run npm install in ~/.config/coc/extensions/
]]--

-- Assign Mapleader
vim.g.mapleader = '-' -- Make sure this is first!

-- Assign working directory
vim.cmd[[let g:wd=getcwd()]]

-- LAZY.VIM LOADING ------------------------------------------------------------
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- END LAZY.VIM LOADING --------------------------------------------------------
--------------------------------------------------------------------------------


-- PLUGINS ---------------------------------------------------------------------
--------------------------------------------------------------------------------
require("lazy").setup({
  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    commit = "b901cf144573b293b6cefeb1ac8c97d5d239ee7a"
  },
  -- { "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   commit = "f247ee700b569ed43f39320413a13ba9b0aef0db"
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    commit = "953313ecf0a92a8e9f2a4afc603731f1fcb331b4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    commit = "38b1d0402c4600543281dc85b3f51884205674b6",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    commit = "e49f1e8ef3e8450a8446cb1f2bbb53c919f60b6d",
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    }
  },
  {
    'phaazon/hop.nvim',
    commit = "1a1eceafe54b5081eae4cb91c723abd1d450f34b"
  },
  -- { 'junegunn/vim-easy-align' },
  {
    'preservim/nerdcommenter',
    commit = "c52b6e731c2b558bc164419d4c369fcc45f0be51"
  },
  {
    'kwkarlwang/bufresize.nvim',
    commit = "3b19527ab936d6910484dcc20fb59bdb12322d8b"
  },
  {
    'neoclide/coc.nvim',
    commit = "6e4e6eaf30fdbaadd9a6be8d4d15a86da4137118",
    build = "yarn install --frozen-lockfile"
  },
  {
    'ThePrimeagen/harpoon',
    commit = "e3e3f7fa6bed92694e21de98cef20f1525b8700d"
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    commit = "9637670896b68805430e2f72cf5d16be5b97a22a"
  },

  {
    'echasnovski/mini.nvim',
    commit = "40086c0a646100c766e8e05cd6e7d75bb1ca37de"
  },

  {
    'jakemason/ouroboros',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    commit = "56726afbf749221b992ee1dbbd251d63ed2a9b15"
  },

  {
    'tpope/vim-obsession',
    commit = "fe9d3e1a9a50171e7d316a52e1e56d868e4c1fe5"
  },

  {
    'Exafunction/codeium.vim',
    commit = "f2d90dedb45e35f7563d2ce3a31c6928f79de678"
  },
})
-- END PLUGINS -----------------------------------------------------------------
--------------------------------------------------------------------------------


-- REQUIRE SETTINGS ------------------------------------------------------------
--------------------------------------------------------------------------------
require("config.options") -- our other settings and mappings
require("config.keymaps") -- our other settings and mappings
-- END REQUIRE SETTINGS --------------------------------------------------------
--------------------------------------------------------------------------------
