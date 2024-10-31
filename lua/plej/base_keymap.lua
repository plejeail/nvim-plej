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

-- Sort lines alphabetically in visual mode {{{
function visual_sort_lines()
  -- Get the start and end positions of the visual selection
  local start_line, _, end_line, _ = unpack(vim.fn.getpos("'<"))
  -- Extract lines in the selection range
  local lines = vim.fn.getline(start_line, end_line)

  -- Sort the lines alphabetically
  table.sort(lines)

  -- Replace the selected lines with the sorted lines
  vim.fn.setline(start_line, lines)
end

-- sort selected lines
vim.api.nvim_set_keymap("v", "sl", "<cmd>lua visual_sort_lines()<CR>", {noremap=true})
-- }}}

