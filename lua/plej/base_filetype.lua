-- plej.base_filetype.lua
vim.api.nvim_create_autocmd( "FileType", {
  pattern = "odin",
  callback = function(ev)
    require('plej.filetype_odin').setup(ev)
  end,
  group = plej,
})


