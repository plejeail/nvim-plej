--
local function setup_lsp_keymap(ev)
  local buf = ev.buf
  vim.bo[buf].formatexpr = nil
  vim.bo[buf].omnifunc   = nil
  vim.api.nvim_buf_set_option(buf, 'shiftwidth', 4)
  vim.api.nvim_buf_set_option(buf, 'softtabstop', 4)
  vim.keymap.set('n', 'K',    vim.lsp.buf.hover,           { buffer = buf })
  vim.keymap.set('n', 'gd',   vim.lsp.buf.definition,      { buffer = buf })
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,      { buffer = buf })
  -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = buf })
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,  { buffer = buf })
end

local function attach_odin(ev)
  setup_lsp_keymap(ev)
  local proj_root = vim.fs.root(ev.buf, { 'ols.json', '.vimproj' })
  require('nvim-tree.api').tree.change_root(proj_root)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  vim.lsp.start({
    name = 'Odin Language Server',
    cmd = { 'ols' },
    root_dir = proj_root,
    capabilities = capabilities,
  })
end

vim.api.nvim_create_autocmd( "FileType", {
  pattern = "odin",
  callback = attach_odin,
  group = plej,
})
