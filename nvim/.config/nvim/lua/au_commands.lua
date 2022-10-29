local aucmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_augroup('bufcheck', {clear = true})

local function augroup(name, fnc)
  fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

vim.api.nvim_create_autocmd('TextYankPost', {
    group    = 'bufcheck',
    pattern  = '*',
    callback = function() vim.highlight.on_yank{timeout=200} 
end })

-- disable mini.indentscope for certain filetype|buftype
augroup('MiniIndentscopeDisable', function(g)
  aucmd("BufEnter", {
    group = g,
    pattern = '*',
    command = "if index(['fzf', 'help'], &ft) >= 0 "
      .. "|| index(['nofile', 'terminal'], &bt) >= 0 "
      .. "| let b:miniindentscope_disable=v:true | endif"
  })
end)
