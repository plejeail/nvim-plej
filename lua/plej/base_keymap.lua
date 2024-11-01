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
  local start = vim.fn.line("'<")
  local ends = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start - 1, ends, false)
  table.sort(lines)
  vim.api.nvim_buf_set_lines(0, start - 1, ends, false, lines)
end
-- sort selected lines
vim.keymap.set('v', '<leader>sl', visual_sort_lines, { desc='sort selected lines', noremap=true })
-- }}}

-- diagnostic navigation
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { buffer = buf })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { buffer = buf })
