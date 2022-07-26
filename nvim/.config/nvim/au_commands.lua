vim.api.nvim_create_augroup('bufcheck', {clear = true})

-- vim.api.nvim_create_autocmd('TextYankPost', {
--     group    = 'bufcheck',
--     pattern  = '*',
--     callback = function() fn.setreg('+', fn.getreg('*'))
--  end })

vim.api.nvim_create_autocmd('TextYankPost', {
    group    = 'bufcheck',
    pattern  = '*',
    callback = function() vim.highlight.on_yank{timeout=200} 
end })
