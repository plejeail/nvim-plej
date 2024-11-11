-- init.lua
-- PLeJ NeoVim configuration

require('plej.base_config')
require('plej.base_keymap')
require('plej.base_filetype')

-- Plugins management {{{
plug = require('plej.plugin_manager'); plug.install()
plug.begin()
plug.register('catppuccin/nvim')
plug.register('L3MON4D3/LuaSnip', { run = 'make install_jsregexp' })
plug.register('hrsh7th/cmp-buffer')
plug.register('hrsh7th/cmp-nvim-lsp')
plug.register('hrsh7th/cmp-path')
plug.register('hrsh7th/nvim-cmp')
plug.register('mfussenegger/nvim-dap')
plug.register('nvim-neotest/nvim-nio')
plug.register('rcarriga/nvim-dap-ui')
plug.register('nvim-lua/plenary.nvim')
plug.register('nvim-lualine/lualine.nvim')
plug.register('nvim-telescope/telescope-fzf-native.nvim', { run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' })
plug.register('nvim-telescope/telescope.nvim')
plug.register('nvim-tree/nvim-tree.lua')
plug.register('nvim-tree/nvim-web-devicons')
plug.register('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
plug.ends()
-- check package updates once a week
plug.update( 7 )
-- }}}

require('plej.project')
require('plej.plugin_lsp')
require('plej.plugin_completion')
require('plej.plugin_nvimtree')
require('plej.plugin_telescope')
require('plej.plugin_lualine')
require('plej.theme_catppuccin')
