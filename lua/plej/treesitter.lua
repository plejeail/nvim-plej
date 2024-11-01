-- plej.treesitter.lua
-- nvim-treesitter configuration

local treesitter = require('nvim-treesitter.configs')
treesitter.prefer_git = false
treesitter.setup({
  highlight = {
    enable = true,
  }
})
local parsers = require('nvim-treesitter.parsers').get_parser_configs()
parsers.odin = {
  install_info = {
    url = vim.fn.stdpath('config') .. '/extern/tree-sitter-odin',
    branch = 'main',
    files = {'src/parser.c'}
  },
  filetype = 'odin',
}

