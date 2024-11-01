-- plej.base_config.lua
-- Custom NeoVim configuration

local o = vim.opt

-- Edition {{{
-- allow reverse insert mode (Ctrl+i)
o.allowrevins = true
-- behaviour on ambiguous characters: use single width
o.ambiwidth = 'single'
-- keep working directory when opening file
o.autochdir = true
-- indent new lines automatically
o.autoindent = true
-- do not auto reload files modified externaly
o.autoread = false
-- do not keep lines indent on copy
o.copyindent = false
-- replace tabs with spaces
o.expandtab = true
-- use Unix end of line style
o.fileformat = 'unix'
o.fileformats = 'unix,dos'
-- add end of line at the end of file
o.fixendofline = true
-- do not force the os to write the file on save
o.fsync = true
-- number of spaces to use for each step of indent
o.shiftwidth = 2
-- smart auto indent
o.smartindent = true
-- number of spaces that count for a tab
o.softtabstop = 2
-- maximum text width before breaking
o.textwidth = 120
-- enable virtual edits
o.virtualedit = 'block'
-- trim white spaces on save
local function trim_trailing_whitespaces()
  local total_lines = vim.api.nvim_buf_line_count(0)
  for i = 1, total_lines do
    local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    local trimmed_line = line:match("^(.-)[%s\t]*$")
    if trimmed_line ~= line then
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, { trimmed_line })
    end
  end
end
vim.api.nvim_create_autocmd("BufWritePre", {
pattern = "*.lua,*.odin",
callback = trim_trailing_whitespaces
})
-- }}}
-- Interface {{{
-- set dark background
o.background = 'dark'
-- indent visually wrapped line
o.breakindent = true
-- screen lines used for command line
o.cmdheight = 0 -- experimental
-- highlight the text line of the cursor of the current window
vim.api.nvim_create_augroup('CursorLineOnlyInActiveWindow', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    group = 'CursorLineOnlyInActiveWindow',
    callback = function() vim.wo.cursorline = true; end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
    group = 'CursorLineOnlyInActiveWindow',
    callback = function() vim.wo.cursorline = false; end,
})
-- prefer English for help files
o.helplang = 'en,fr'
-- always show the status line
o.laststatus = 2
-- show trailing tabs and spaces
o.list = true
o.listchars = 'tab:>-,lead:.,trail:-'
-- pause when listings fill the whole screen
o.more = true
-- print the line numbers
o.number = true
-- enable pseudo transparency for the popup menu
o.pumblend = 10
-- maximum redraw time allowed
o.redrawtime = 1000
-- maximum number of lines kept beyond visible screen
o.scrollback = 10000
-- minimum number of lines to surround the cursor
o.scrolloff = 7
-- token to show on the start of wrapped lines
o.showbreak = '+>+ '
-- show (partially) entered commands in status line
o.showcmdloc = 'statusline'
-- show matching bracket
o.showmatch = true
-- always show the sign column
o.signcolumn = 'auto:1-3'
-- enable transparency for floating windows
o.winblend = 10
-- }}}
-- History and undo {{{
-- maximum size of history
o.history  = 10000
-- keep highlighted all matches of the previous search pattern
o.hlsearch = true
-- enable persistent storage of undoes
o.undofile = true
-- maximum number of undoes kept in memory
o.undolevels = 1000
-- }}}
-- Search and completion {{{
-- options for insert mode completion
o.completeopt = 'menu,menuone,popup,noinsert'
-- ignore case in search patterns
o.ignorecase = true
-- show offscreen substitutions in a preview window
o.inccommand = 'split'
-- incremental search
o.incsearch = true
-- maximum number of items to show in the completion menu
o.pumheight = 20
-- show tag and tidied-up form on insert completion
o.showfulltag = true
-- when searching, ignore case if all lowercase
o.smartcase = true
-- use smartcase for tag search
o.tagcase = 'followscs'
-- }}}
-- Folding {{{
-- close folds when leaving them
-- o.foldclose = 'all'
-- fold column size
o.foldcolumn = '1'
-- enable folds
o.foldenable = true
-- close all folds by default
o.foldlevelstart = 0
-- use the fold-markers by default
o.foldmethod = 'marker'
-- reduce maximum nesting of folds to 4 folds
o.foldnestmax = 4
-- open folds for ny relevant command
o.foldopen = 'block,hor,insert,jump,mark,quickfix,search,tag,undo'
-- }}}
-- Spell checking {{{
-- enable spell checking
o.spell = true
-- do not consider end of sentence
o.spellcapcheck = '' -- '[.]'
-- languages used for spell checking
o.spelllang = 'en'
-- spell suggestions based on text and sound
o.spellsuggest = 'double'
-- }}}

