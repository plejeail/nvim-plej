require("catppuccin").setup({
  color_overrides = {
  },
  transparent_background = true,
  show_end_of_buffer = true,
  integrations = {
    cmp = true,
    dap = true,
    nvimtree = true,
    telescope = { enabled = true, },
  },
})

vim.cmd.colorscheme "catppuccin"
vim.api.nvim_set_hl(0, 'CursorLine', { underdouble = true })

