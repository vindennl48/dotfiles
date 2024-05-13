require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<leader>x"] = "select_vertical",
        ["<leader>y"] = "select_horizontal",
      }
    }
  },
}


-- KEYMAPS ---------------------------------------------------------------------
--------------------------------------------------------------------------------
-- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, {})
-- vim.keymap.set('n', '<leader>fs', function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

