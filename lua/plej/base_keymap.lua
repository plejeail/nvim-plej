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

vim.keymap.set('n', '<leader>rv', reload_init, { desc='reload vim configuration', noremap=true })
-- }}}

-- Sort lines alphabetically in visual mode {{{
local function visual_sort_lines()
  local first_row = vim.fn.line('v')
  local last_row  = vim.fn.line('.')
  if first_row > last_row then
    first_row, last_row = last_row, first_row
  end
  local lines = vim.api.nvim_buf_get_lines(0, first_row - 1, last_row, false)
  table.sort(lines)
  vim.api.nvim_buf_set_lines(0, first_row - 1, last_row, false, lines)
end

vim.keymap.set('v', '<leader>sl', visual_sort_lines, { desc='sort selected lines', noremap=true })
-- }}}

-- diagnostic navigation
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = buf })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = buf })
