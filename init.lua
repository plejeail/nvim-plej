-- init.lua
-- PLeJ NeoVim configuration

require('plej.base_config')
require('plej.base_keymap')

-- Plugins management {{{
plug = require('plej.plug'); plug.install()
plug.begin()
plug.register('catppuccin/nvim')
plug.register('L3MON4D3/LuaSnip', { run = 'make install_jsregexp' })
plug.register('hrsh7th/cmp-buffer')
plug.register('hrsh7th/cmp-nvim-lsp')
plug.register('hrsh7th/cmp-path')
plug.register('hrsh7th/nvim-cmp')
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

require('plej.treesitter')
require('plej.lsp')
require('plej.completion')
require('plej.nvimtree')
require('plej.telescope')
require('plej.lualine')
require('plej.themes.catppuccin')
