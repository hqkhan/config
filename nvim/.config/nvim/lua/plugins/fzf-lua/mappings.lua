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

-- Misc
map_fzf('n', "<leader>f?", "builtin",           { desc = "builtin commands" })
map_fzf('n', "<C-f>", "files",                  { desc = "Files",
    prompt = 'Files❯ ',
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
})

map_fzf('n', "<Space><CR>", "buffers",          { desc = "Buffers",
    winopts = {
        preview = { vertical = "down:65%", horizontal = "right:75%", }
    },
})

-- Git
map_fzf('n', "<leader>bcm", "git_bcommits",     { desc = "Git buffer commits" })
map_fzf('n', "<leader>cm", "git_commits",       { desc = "Git commits" })
map_fzf('n', "<C-g>", "git_files",              { desc = "Git Files" })
map_fzf('n', "<leader>co", "git_branches",      { desc = "Checkout git branches" })

-- Grep
map_fzf('n', "<leader>rg", "grep",              { desc = "Grep" })
map_fzf('n', "<leader>cw", "grep_cword",        { desc = "Grep current word" })
map_fzf('n', "<leader>lg", "live_grep",         { desc = "Live grep" })

local grep_cur_buf_opts = {
    winopts = {
        preview = {  vertical = "down:0%", horizontal = "right:0%",  }
    },
}
map_fzf('n', "<leader>bl", "blines",
vim.tbl_extend("force", grep_cur_buf_opts,           { desc = "Live grep current buffer" }))
-- TODO pass in current word under cursor using expand
map_fzf('n', "<leader>lG", "lgrep_curbuf", { desc = "Live grep current buffer" })
map_fzf('n', "<leader>LG", "live_grep_resume",
vim.tbl_extend("force", grep_cur_buf_opts,           { desc = "Live grep resume" }))

map_fzf('n', "<leader>tm", "tmux_buffers",           { desc = "tmux buffers" })

-- Config files
map_fzf('n', "<leader>h", "files",
    { desc = "Grep current word",
      cwd = '~/config',
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
    })

-- LSP
map_fzf('n', "<leader>lS", "lsp_workspace_symbols",   { desc = "Workspace symbols" })
map_fzf('n', "<leader>ls", "lsp_document_symbols",    { desc = "Document symbols" })
map_fzf('n', "<leader>lr", "lsp_references",          { desc = "LSP references" })
map_fzf('n', "<leader>ld", "lsp_definitions",         { desc = "LSP definitinos" })
map_fzf('n', "<leader>lD", "lsp_declaration",         { desc = "LSP declaration" })

map_fzf('n', "<leader>HT", "help_tags",               { desc = "nvim help tags" })

-- Full screen git status
map_fzf('n', '<leader>gs', "git_status_tmuxZ",
    { desc = "git status (fullscreen)",
        winopts = {
            fullscreen = true,
            preview = {
                vertical = "down:70%",
                horizontal = "right:70%",
            }
        }
    })
map_fzf('n', '<leader>gS', "git_status", vim.tbl_extend("force", {show_cwd_header = false},            { desc = "git status" }))
