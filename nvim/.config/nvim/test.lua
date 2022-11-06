-- Set vim settings
require('settings')

-- MacOS clipboard
if require'utils'.is_darwin() then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
  }
end

if require'utils'.is_darwin() then
    vim.g.python3_host_prog       = '/usr/local/bin/python3'
else
    vim.g.python3_host_prog       = '/usr/bin/python3'
end

-- use ':grep' to send resulsts to quickfix
-- use ':lgrep' to send resulsts to loclist
if vim.fn.executable('rg') == 1 then
    o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
    o.grepformat = '%f:%l:%c:%m'
end

-- Disable providers we do not care a about
vim.g.loaded_python_provider  = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  -- 'matchit',
   --'matchparen',
}
-- disable default fzf plugin if not
-- root since we will be using fzf-lua
if not require'utils'.is_root() then
  table.insert(disabled_built_ins, 'fzf')
end
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.g.markdown_fenced_languages = {
  'vim',
  'lua',
  'cpp',
  'sql',
  'python',
  'bash=sh',
  'console=sh',
  'javascript',
  'typescript',
  'js=javascript',
  'ts=typescript',
  'yaml',
  'json',
}

-- Map leader to <space>
vim.g.mapleader      = ','
vim.g.maplocalleader = ','

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.api.nvim_command('set rtp-=/usr/share/vim/vimfiles')

require 'plugins'
require 'au_commands'
require 'keymaps'

-- set colorscheme to modified embark
-- https://github.com/embark-theme/vim
-- vim.g.embark_transparent = true
-- vim.g.embark_terminal_italics = true
vim.g.lua_embark_transparent = true
pcall(vim.cmd, [[colorscheme lua-embark]])
