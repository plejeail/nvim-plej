-- base_keymap.lua
-- Utility shortcuts.
vim.g.mapleader = '<'

-- reload NeoVim configuration {{{
local function reload_init()
    package.loaded['plej.auto']    = nil
    package.loaded['plej.keymaps'] = nil
    package.loaded['plej.config']  = nil
    package.loaded['plej.utils']   = nil
    package.loaded.plej            = nil

    dofile(vim.api.nvim_list_runtime_paths()[1] .. '/init.lua')
    print('configuration reloaded')
end
-- reload vim configuration
vim.api.nvim_set_keymap("n", "<leader>rv", "<cmd>lua reload_init()<CR>", { desc="", noremap=true })
-- }}}
