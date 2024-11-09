-- plej.telescope.lua
-- Configure the plugin telescope
require('nvim-web-devicons').setup()
local telescope = require('telescope')
telescope.setup({
  defaults = {
    sorting_strategy = 'descending',
    selection_strategy = 'closest',
    scroll_strategy = 'cycle',
    layout_strategy = 'horizontal',
    winblend = 5,
    wrap_results = true,
    prompt_prefix = '>>> ',
    border = true,
    path_display = { 'filename_first' },
    -- mappings = {}
    treesitter = true,
    theme = 'dropdown',
  },
  pickers = {
    buffers = { layout_strategy = 'vertical', layout_config = { vertical = { width = 0.4, height = 0.5 } } },
    commands = { layout_strategy = 'bottom_pane', layout_config = { bottom_pane = { height = 0.3 } } },
    find_files = { layout_strategy = 'vertical', layout_config = { vertical = { width = 0.4 } } },
    spell_suggest = { layout_strategy = 'cursor', layout_config = { cursor = { width = 0.3, height = 0.2 } } },
  },
extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
})

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Search buffers [Telescope]' })
vim.keymap.set('n', '<leader>fc', builtin.commands,   { desc = 'Find command [Telescope]' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file [Telescope]' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Help [Telescope]' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps,    { desc = 'Keymaps [Telescope]' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Find token [Telescope]' })
vim.keymap.set('n', '<leader>fq', builtin.quickfix,   { desc = 'Quickfixes menu [Telescope]' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Spell suggestions [Telescope]' })
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = 'Spell suggestions [Telescope]' })
vim.keymap.set('n', '<leader>ft', builtin.tags,       { desc = 'Search rags [Telescope]' })
vim.keymap.set('n', '<leader>dl', builtin.diagnostics,{ desc = 'Search rags [Telescope]' })

