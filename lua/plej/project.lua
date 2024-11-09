-- plej.project.lua
-- Find project root {{{
function get_project_root(buf)
  return vim.fs.root(buf, '.vimproj')
end
-- }}}

-- Parse project file {{{
function parse_project_file(filename)
  local file = io.open(filename, 'r')
  if not file then
    error('Could not open the file: ' .. filename)
  end

  local config = {}

  local has_name = false
  -- Iterate over each line in the file
  for line in file:lines() do
    -- Trim any leading or trailing white space from the line
    line = line:match('^%s*(.-)%s*$')

    -- Skip empty lines and lines that don't contain an '=' sign
    if line:find('=') then
      -- Split the line into key and value
      local key, value = line:match('^(%S+)%s*=%s*(.-)%s*$')
      if key and value then
        -- Normalize the key and map it to Lua object field names
        key = key:lower()

        if key == 'dap_conf' then
          config.dap_conf = value
        elseif key == 'name' then
          has_name = true
          if _G._plej_proj ~= nil and value == _G._plej_proj.name then
            file:close()
            _G._plej_proj.done = true
            return _G._plej_proj
          end
          config.name = value
        elseif key == 'flags_debug' then
          config.debug_flags = value
        elseif key == 'flags_release' then
          config.release_flags = value
        elseif key == 'flags_test' then
          config.test_flags = value
        elseif key == 'test_folder' then
          config.test_folder = value
        else -- additional key/value pairs
          config[key] = value
        end
      end
    end
  end
  file:close()

  if not has_name then
    error('Missing project "name" field')
  end
  config.done = false
  _G._plej_proj = config
  return config
end
-- }}}

-- Setup project keymap {{{
function setup_project_keymap(ev)
  local buf = ev.buf
  vim.bo[buf].formatexpr = nil
  vim.bo[buf].omnifunc   = nil
  vim.api.nvim_buf_set_option(buf, 'shiftwidth', 4)
  vim.api.nvim_buf_set_option(buf, 'softtabstop', 4)
  vim.keymap.set('n', 'K',    vim.lsp.buf.hover,            { buffer = buf })
  vim.keymap.set('n', 'gd',   vim.lsp.buf.definition,       { buffer = buf })
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,      { buffer = buf })
-- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = buf })
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,  { buffer = buf })
end
-- }}}

-- Attach lsp to buffer {{{
function attach_project_lsp(ev, lsp_name, lsp_cmd, proj_root)
  require('nvim-tree.api').tree.change_root(proj_root)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  vim.lsp.start({
    name = lsp_name,
    cmd = lsp_cmd,
    root_dir = proj_root,
    capabilities = capabilities,
  })
end
-- }}}

-- Run task in nvim terminal {{{
function run_task(command)
  vim.api.nvim_command('botright split | resize 10')
  vim.api.nvim_command('terminal')

  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'readonly', true)
  vim.fn.chansend(vim.b.terminal_job_id, command .. '\r\n')
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      vim.api.nvim_command('bd!')  -- Force close the buffer
    end,
  })
  vim.api.nvim_command("stopinsert")
end
-- }}}

