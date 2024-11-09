-- plej.filetype_odin.lua
-- What to run when attaching odin file


function setup(ev)
  require('plej.project')
  local path = get_project_root(ev.buf)
  if path == nil then
    return
  end
  local project = parse_project_file(path .. '/.vimproj')
  if not project.done then
    setup_project_keymap(ev)
    -- vim.api.nvim_buf_set_option(ev.buf, 'foldmethod', 'expr')
    -- vim.api.nvim_buf_set_option(ev.buf, 'foldexpr', 'nvim_treesitter#foldexpr()')
    project.cmd_dbg = string.format('odin build %s/%s --out:%s/build/debug/%s %s',
        path, project.source_folder,
        path, project.binary,
        project.debug_flags)
    project.cmd_rel = string.format('odin build %s/%s --out:%s/build/release/%s %s',
        path, project.source_folder,
        path, project.binary,
        project.release_flags)
    project.cmd_test = string.format('odin test %s/%s --out:build/debug/test_%s %s',
        path, project.test_folder, project.binary,
        project.test_flags)
  end
  attach_project_lsp(ev, 'Odin Language Server', { 'ols' }, path)

  require('plej.plugin_dap')
  setup_dap_keymap()

  local dap = require('dap')
  local t = path .. '/build/debug/test_' .. project.binary
  dap.configurations.odin = {
    {
      type = 'cppvsdbg',
      request = 'launch',
      name = 'Debug',
      program = path .. '/build/debug/' .. project.binary,
      args = {'--interpreter=vscode', '--engineLogging=C:/Users/pierre/vsdbg.log'},
      clientID = 'vscode',
      clientName = 'Visual Studio Code',
      columnsStartAt1 = true,
      cwd = path .. '/build/debug',
      externalConsole = true,
      externalTerminal = true,
      linesStartAt1 = true,
      locale = "en",
      pathFormat = "path",
    },
    {
      type = 'cppvsdbg',
      request = 'launch',
      name = 'Release',
      program = path .. '/build/release/' .. project.binary,
      args = {'--interpreter=vscode', '--engineLogging=C:/Users/pierre/vsdbg.log'},
      clientID = 'vscode',
      clientName = 'Visual Studio Code',
      columnsStartAt1 = true,
      cwd = path .. '/build/release',
      externalConsole = true,
      externalTerminal = true,
      linesStartAt1 = true,
      locale = "en",
      pathFormat = "path",
    },
    {
      name = 'Tests',
      type = 'cppvsdbg',
      request = 'launch',
      program = 'test_' .. project.binary,
      args = {'--interpreter=vscode', '--engineLogging=C:/Users/pierre/vsdbg.log'},
      clientID = 'vscode',
      clientName = 'Visual Studio Code',
      columnsStartAt1 = true,
      cwd = path .. '/build/debug',
      externalConsole = true,
      externalTerminal = true,
      linesStartAt1 = true,
      locale = "en",
      pathFormat = "path",
    },
  }

  vim.keymap.set('n', '<leader>bd', function() run_task(project.cmd_dbg) end,  { buffer = 0 })
  vim.keymap.set('n', '<leader>br', function() run_task(project.cmd_rel) end,  { buffer = 0 })
  vim.keymap.set('n', '<leader>bt', function() run_task(project.cmd_test) end, { buffer = 0 })
end

return {
  setup = setup,
}
