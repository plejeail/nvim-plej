-- nvimtree.lua
-- Explorer plugin configuration
require("nvim-tree").setup({
  hijack_cursor = true,
  auto_reload_on_write = false,
  disable_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  select_prompts = false,
  sort = {
    sorter = 'case_sensitive',
    folders_first = true,
    files_first = false,
  },
  view = {
    cursorline = true,
    debounce_delay = 30,
    side = 'left',
    signcolumn = 'yes',
    width = { min = 25, max = 36 },
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = 'editor',
        border = 'shadow',
        width = 40,
        height = 100,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    full_name = false,
    root_folder_label = function(path) -- folder name
      return path:match("([^\\/]+)[\\/][^\\/]+$")
    end,
    indent_width = 2,
    special_files = {},
    hidden_display = 'simple',
    symlink_destination = true,
    highlight_git = 'icon',
    highlight_diagnostics = 'icon',
    highlight_opened_files = 'none',
    highlight_modified = 'none',
    highlight_hidden = 'none',
    highlight_bookmarks = 'none',
    highlight_clipboard = 'none',
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      git_placement = "before",
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
    cygwin_support = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.WARNING,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      warning = "",
      error = "",
    },
  },
  filters = {
    enable = false,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 250,
    ignore_dirs = {
      "/.*",
      "/build",
      "/node_modules",
      "/target",
    },
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable =false,
      global = false,
      restrict_above_cwd = false,
    },
  },
})

local api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'toggle nvim-tree' })
