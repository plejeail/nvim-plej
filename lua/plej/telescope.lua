-- plej.telescope.lua
-- Configure the plugin telescope
local telescope = require('telescope')
telescope.setup({
  defaults = {
    sorting_strategy = 'descending',
    selection_strategy = 'closest',
    scroll_strategy = 'cycle',
    layout_strategy = 'center',
    winblend = 10,
    wrap_results = true,
    prompt_prefix = '>>> ',
    border = false,
    path_display = { 'filename_first' },
    -- mappings = {}
    treesitter = true,
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

