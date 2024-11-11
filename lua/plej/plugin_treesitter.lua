-- plej.plugin_treesitter.mlua
return {
  setup = function(parser_name)
    require('nvim-treesitter.configs').setup {
      ensure_installed = { parser_name },
      sync_install = false,
      auto_install = false,
      highlight = {
        disable = function(lang, buf)
          local max_filesize = 500 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      }
    }
  end
}
