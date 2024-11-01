-- init.lua
-- PLeJ NeoVim configuration

require('plej.base_config')
require('plej.base_keymap')

-- Plugins management {{{
plug = require('plej.plug'); plug.install()
plug.begin()
plug.register('catppuccin/nvim')
plug.register('nvim-tree/nvim-web-devicons')
plug.register('nvim-tree/nvim-tree.lua')
plug.register('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
plug.register('nvim-telescope/telescope-fzf-native.nvim', { run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' })
plug.register('nvim-lua/plenary.nvim')
plug.register('nvim-telescope/telescope.nvim')
plug.ends()
-- check package updates once a week
plug.update( 7 )
-- }}}

require('plej.nvimtree')
require('plej.treesitter')
require('plej.telescope')
require('plej.themes.catppuccin')

