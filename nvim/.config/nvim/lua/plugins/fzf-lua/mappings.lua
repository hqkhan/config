------------------------------------
-------------Keymaps----------------
------------------------------------
local map_fzf = function(mode, key, f, options, buffer)

  local desc = nil
  if type(options) == 'table' then
    desc = options.desc
    options.desc = nil
  elseif type(options) == 'function' then
    desc = options().desc
  end

  print(require('plugins.fzf-lua'))
  local rhs = function()
    if not pcall(require, 'fzf-lua') then
      require('packer').loader('fzf-lua')
    end
    require('plugins.fzf-lua')[f](options or {})
  end

  local map_options = {
    silent = true,
    buffer = buffer,
    desc   = desc or string.format("FzfLua %s", f),
  }

  vim.keymap.set(mode, key, rhs, map_options)
end

vim.api.nvim_set_keymap('n', '<leader>f?',
    "<cmd>lua require('fzf-lua').builtin()<CR>",
    { noremap = true, silent = true })

-- Find commits for current file
vim.api.nvim_set_keymap('n', '<leader>bcm',
    "<cmd>lua require('fzf-lua').git_bcommits()<CR>",
    { noremap = true, silent = true })

 -- Files
vim.api.nvim_set_keymap('n', '<c-f>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

 -- Git
vim.api.nvim_set_keymap('n', '<leader>co',
    "<cmd>lua require('fzf-lua').git_branches()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<c-g>',
    "<cmd>lua require('fzf-lua').git_files()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cm',
    "<cmd>lua require('fzf-lua').git_commits()<CR>",
    { noremap = true, silent = true })

-- Buffers
vim.api.nvim_set_keymap('n', '<Space><CR>',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })

-- Rg
vim.api.nvim_set_keymap('n', '<leader>rg',
    "<cmd>lua require('fzf-lua').grep()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cw',
    "<cmd>lua require('fzf-lua').grep_cword()<CR>",
    { noremap = true, silent = true })

-- ~/config
vim.api.nvim_set_keymap('n', '<leader>h',
    "<cmd>lua require('fzf-lua').files({ cwd = '~/config' })<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>bl',
    "<cmd>lua require('fzf-lua').blines()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lS',
    "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ls',
    "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lr',
    "<cmd>lua require('fzf-lua').lsp_references()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ld',
    "<cmd>lua require('fzf-lua').lsp_definitions()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lD',
    "<cmd>lua require('fzf-lua').lsp_declaration()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lg',
    "<cmd>lua require('fzf-lua').live_grep()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lG',
    "<cmd>lua require('fzf-lua').live_grep_resume()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>HT',
    "<cmd>lua require('fzf-lua').help_tags()<CR>",
    { noremap = true, silent = true })

-- Full screen git status
map_fzf('n', '<leader>gS', "git_status_tmuxZ", { desc = "git status (fullscreen)",
  winopts = {
    fullscreen = true,
    preview = {
      vertical = "down:70%",
      horizontal = "right:70%",
    }
  }
})
