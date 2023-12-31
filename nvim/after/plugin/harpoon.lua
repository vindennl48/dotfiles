
local set = vim.keymap.set
set(
  "n",
  "<leader>hh",
  function()
    require("harpoon.ui").toggle_quick_menu()
  end,
  { noremap = false, desc = "Open harpoon menu" }
)

set(
  "n",
  "<leader>ha",
  function()
    require("harpoon.mark").add_file()
  end,
  { noremap = false, desc = "Add file to harpoon" }
)

set(
  "n",
  "<leader>h1",
  function()
    require("harpoon.ui").nav_file(1)
  end,
  { noremap = false, desc = "Go to harpoon file 1" }
)

set(
  "n",
  "<leader>h2",
  function()
    require("harpoon.ui").nav_file(2)
  end,
  { noremap = false, desc = "Go to harpoon file 2" }
)

set(
  "n",
  "<leader>h3",
  function()
    require("harpoon.ui").nav_file(3)
  end,
  { noremap = false, desc = "Go to harpoon file 3" }
)

set(
  "n",
  "<leader>h4",
  function()
    require("harpoon.ui").nav_file(4)
  end,
  { noremap = false, desc = "Go to harpoon file 4" }
)

set(
  "n",
  "<leader>h5",
  function()
    require("harpoon.ui").nav_file(5)
  end,
  { noremap = false, desc = "Go to harpoon file 5" }
)

set(
  "n",
  "<leader>h6",
  function()
    require("harpoon.ui").nav_file(6)
  end,
  { noremap = false, desc = "Go to harpoon file 6" }
)
