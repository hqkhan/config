-- Do not use plugins when running as root or neovim < 0.5
if require'utils'.is_root() or not require'utils'.has_neovim_v05() then
  return
end

-- we don't want the compilation file in '~/.config/nvim'
-- place it under '~/.local/shared/nvim/plugin' instead
local compile_suffix = "/plugin/packer_compiled.lua"
local install_suffix = "/site/pack/packer/%s/packer.nvim"
local install_path = vim.fn.stdpath("data") .. string.format(install_suffix, "opt")
local compile_path = vim.fn.stdpath("data") .. compile_suffix
-- Call bootstrap here to install packer
local ok, packer = pcall(require('plugins.packer_bootstrap'), install_path, compile_path)
if not ok or not packer then return end -- user cancelled installation?

-- Packer commands
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
vim.cmd [[command! PC PackerCompile]]
vim.cmd [[command! PS PackerStatus]]
vim.cmd [[command! PU PackerSync]]

-- Packer config
local config = {
  compile_path = compile_path,
  git = {
    -- never fail if plugin author rebased the git repo
    subcommands = { update = 'pull --progress --rebase=true' }
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = 'rounded' })
    end
  }
}

-- hook to avoid the 'packer.compile: Complete' notify
packer.on_compile_done = function() end

-- Setup our plugins
packer.startup({ require("plugins.pluginList"), config = config })

if vim.loop.fs_stat(config.compile_path) then
  -- since we customized the compilation path for packer
  -- we need to manually load 'packer_compiled.lua'
  vim.cmd("luafile " .. config.compile_path)
else
  -- no 'packer_compiled.lua', we assume this is the
  -- first time install, 'sync()' will clone|update
  -- our plugins and generate 'packer_compiled.lua'
  packer.sync()
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    return packer[key]
  end
})

return plugins
