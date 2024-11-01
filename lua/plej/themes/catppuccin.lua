require("catppuccin").setup({
  color_overrides = {
  },
  transparent_background = true,
  show_end_of_buffer = true,
  integrations = {
    cmp = true,
    dap = true,
    dap_ui = true,
    nvimtree = true,
    telescope = { enabled = true, },
  },
})

vim.cmd.colorscheme "catppuccin"
vim.api.nvim_set_hl(0, 'CursorLine',     { underdouble = true })
vim.api.nvim_set_hl(0, 'LineNr',         { fg='#70b0c0' })
vim.api.nvim_set_hl(0, 'CursorLineNr',   { fg='#a0a060' })
vim.api.nvim_set_hl(0, 'SignColumn',     { fg='#9060a0' })
vim.api.nvim_set_hl(0, 'CursorLineSign', { fg='#a070b0' })
vim.api.nvim_set_hl(0, 'StatusLineNC',   { fg='#83778a' })
vim.api.nvim_set_hl(0, 'Whitespace',     { fg='#706072' })

