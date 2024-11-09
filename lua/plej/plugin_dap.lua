-- plej.dap.lua
-- Debugging adapter
local dap = require('dap')

-- Setup UI {{{
local dapui = require("dapui")
dapui.setup({
    controls = {
      element = 'repl',
      enabled = true,
      icons = {
        disconnect = '',
        pause = '',
        play = '',
        run_last = '',
        step_back = '',
        step_into = '',
        step_out = '',
        step_over = '',
        terminate = ''
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = 'single',
      mappings = {
        close = { 'q', '<Esc>' }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = '',
      current_frame = '',
      expanded = ''
    },
    layouts = { {
        elements = { {
            id = 'scopes',
            size = 0.25
          }, {
            id = 'breakpoints',
            size = 0.25
          }, {
            id = 'stacks',
            size = 0.25
          }, {
            id = 'watches',
            size = 0.25
          } },
        position = 'left',
        size = 40
      }, {
        elements = {
          -- { id = 'repl', size = 0.1 },
          {
            id = 'console',
            size = 1.0,
          } },
        position = 'bottom',
        size = 10
      } },
    mappings = {
      edit = 'e',
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      repl = 'r',
      toggle = 't'
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  })
-- }}}

-- attach dapui to dap commands {{{
dap.listeners.before.attach.dapui_config = function()
dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
--dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
--dapui.close()
end
-- }}}

-- shake hand with vsdbg {{{
function shake_hand(self, request_payload)
  local rpc = require('dap.rpc')
  local function send_payload(client, payload)
    local msg = rpc.msg_with_content_length(vim.json.encode(payload))
    client.write(msg)
  end
  local signResult = io.popen('node ' .. vim.fn.stdpath('config') .. '/extern/vsdbg_handshake.js ' .. request_payload.arguments.value)
  if signResult == nil then
    utils.notify('error while signing handshake', vim.log.levels.ERROR)
    print('error while signing handshake')
    return
  end
  local signature = signResult:read("*a")
  signature = string.gsub(signature, '\n', '')
  local response = {
    type = "response",
    seq = 0,
    command = "handshake",
    request_seq = request_payload.seq,
    success = true,
    body = {
      signature = signature
    }
  }
  send_payload(self.client, response)
end
-- }}}

-- Adapter vsdbg {{{
dap.adapters.cppvsdbg = {
  id = 'cppvsdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/ms-vscode.cpptools/debugAdapters/vsdbg/bin/vsdbg',
  -- command = vim.fn.stdpath('data') .. '/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7',
  args = { "--interpreter=vscode" },
  options = { externalTerminal = true, },
  reverse_request_handlers = { handshake = shake_hand, },
  runInTerminal =  true,
}
-- }}}

-- Setup keymap {{{
function setup_dap_keymap(buf)
  vim.keymap.set('n', '<F1>',  dap.toggle_breakpoint, { buffer = buf, })
  vim.keymap.set('n', '<F2>',  dap.up, { buffer = buf, })
  vim.keymap.set('n', '<F3>',  dap.down, { buffer = buf, })
  vim.keymap.set('n', '<F4>',  dap.pause, { buffer = buf, })
  vim.keymap.set('n', '<F5>',  dap.continue, { buffer = buf, })
  vim.keymap.set('n', '<F6>',  dapui.toggle,  { buffer = buf, })
  vim.keymap.set('n', '<F7>',  '<cmd>lua require("dapui").eval("', { buffer = buf, })
  vim.keymap.set('n', '<F9>',  dap.step_back, { buffer = buf, })
  vim.keymap.set('n', '<F10>', dap.step_over, { buffer = buf, })
  vim.keymap.set('n', '<F11>', dap.step_into, { buffer = buf, })
  vim.keymap.set('n', '<F12>', dap.step_out,  { buffer = buf, })
end
-- }}}

