-- plej.plug.lua
-- Plug integration in NeoVim

-- write_timestamp {{{
local function write_timestamp(filepath, timestamp)
  local f, err = io.open(filepath, 'w')
  if f then
    f:write(tostring(timestamp))
    f:close()
  end
end
-- }}}
-- read_timestamp {{{
local function read_timestamp(filepath)
  local f, err = io.open(filepath, 'r')
  if f then
    local content = f:read("*a")
    f:close()
    return tonumber(content)
  end
  return nil
end
-- }}}

-- install plug automatically if not already done {{{
local function install()
  local plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  local autoload_dir = vim.fn.stdpath('data') .. '/site/autoload'
  local plug_path = autoload_dir .. '/plug.vim'

  if vim.fn.filereadable(plug_path) == 0 then
    print('plug not found')
    if vim.fn.has('win32') then
	  vim.fn.system({'powershell', '-Command', 'New-Item -Path "' .. autoload_dir .. '" -ItemType Directory -Force'})
      vim.fn.system({'powershell', '-Command', 'Invoke-WebRequest -Uri ' .. plug_url .. ' -OutFile "' .. plug_path .. '"'})
    else
      vim.fn.system({ 'mkdir', '-fp', autoload_dir })
      vim.fn.system({ 'curl', '-fLo', plug_path, '--create-dirs', plug_url })
    end
  	if not vim.v.shell_error == 0 then
  	  print('error failed to download plug')
	  return
  	end

    write_timestamp(vim.fn.stdpath('data') .. '/plug_last_update.time', os.time())

    vim.cmd('source ' .. plug_path)
	vim.call('PlugInstall')
  end
end
-- }}}

-- check package updates every X days {{{
local function update(days)
  local time_file  = vim.fn.stdpath('data') .. '/plug_last_update.time'
  local last_time  = read_timestamp(time_file) or 0
  local check_time = os.time()
  if (check_time - last_time) < days * 8640000 then
	return
  end

  vim.cmd('PlugUpdate')
  write_timestamp(time_file, check_time)
end
-- }}}

-- configuration stuff {{{
local apply_config = function(plugin_name)
  local fn = configs.lazy[plugin_name]
  if type(fn) == 'function' then fn() end
end
-- Plug object
local configs = {
  lazy = {},
  start = {}
}
-- }}}

-- load package {{{
local function register(repo, opts)
  local plug_name = function(repo)
    return repo:match("^[%w-]+/([%w-_.]+)$")
  end

  opts = opts or vim.empty_dict()

  -- we declare some aliases for `do` and `for`
  opts['do'] = opts.run
  opts.run = nil

  opts['for'] = opts.ft
  opts.ft = nil

  vim.call('plug#', repo, opts)

  -- Add basic support to colocate plugin config
  if type(opts.config) == 'function' then
    local plugin = opts.as or plug_name(repo)

    if opts['for'] == nil and opts.on == nil then
      configs.start[plugin] = opts.config
    else
      configs.lazy[plugin] = opts.config
      vim.api.nvim_create_autocmd('User', {
        pattern = plugin,
        once = true,
        callback = function()
          apply_config(plugin)
        end,
      })
    end
  end
end
-- }}}

-- end package loading {{{
local function plug_end()
  vim.fn['plug#end']()

  for i, config in pairs(configs.start) do
    config()
  end
end
-- }}}

-- return plug object
return {
  install = install,
  update  = update,
  pull    = register,
  begin   = vim.fn['plug#begin'],
  ends    = plug_end,
}
