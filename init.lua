-- init.lua
-- PLeJ NeoVim configuration

require('plej.base_config')
require('plej.base_keymap')

-- Plugins management {{{
plug = require('plej.plug'); plug.install()
plug.begin()
plug.register('catppuccin/nvim')
plug.ends()
-- check package updates once a week
plug.update( 7 )
-- }}}

require('plej.themes.catppuccin')

