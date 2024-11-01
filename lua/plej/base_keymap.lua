-- base_keymap.lua
-- Utility shortcuts.
vim.g.mapleader = '<'

-- reload NeoVim configuration {{{
local function reload_init()
  package.loaded['plej.base_config'] = nil
  package.loaded['plej.base_keymap'] = nil
  package.loaded['plej.plug']        = nil
  package.loaded['plej.telescope']   = nil
  package.loaded['plej.treesitter']  = nil
  package.loaded['plej.themes.catppuccin'] = nil
  package.loaded.plej                = nil

  dofile(vim.fn.stdpath('config') .. '/init.lua')
  print('configuration reloaded')
end
-- reload vim configuration
vim.keymap.set('n', '<leader>rv', reload_init, { desc='reload vim configuration', noremap=true })
-- }}}

-- Sort lines alphabetically in visual mode {{{
local function visual_sort_lines()
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
vim.keymap.set('v', '<leader>sl', visual_sort_lines, { desc='sort selected lines', noremap=true })
-- }}}

