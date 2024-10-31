-- init.lua
-- PLeJ NeoVim configuration

require('plej.base_config')

plug = require('plej.plug'); plug.install()

plug.begin()
plug.ends()

-- check package updates once a week
plug.update( 7 )
