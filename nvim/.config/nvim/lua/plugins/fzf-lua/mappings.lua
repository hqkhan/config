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
map_fzf('n', "<leader>cW", "grep_cword",        { desc = "Grep current word in project" })
map_fzf('n', '<leader>cw', "grep_curbuf", function()
  return {
    desc = 'Live grep current buffer',
    prompt = 'Buffer❯ ',
    winopts = {
        preview = { vertical = "down:65%", horizontal = "right:75%", }
    },
    search = vim.fn.expand("<cword>"),
  }
end)
map_fzf('n', "<leader>lG", "live_grep", { desc = "Live grep"})
map_fzf('n', "<leader>lg", "lgrep_curbuf",
    function() return { desc = "Live grep current buffer",
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
}end)

map_fzf('n', "<leader>bl", "blines", { desc = "buffer lines",
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
})
-- TODO pass in current word under cursor using expand
map_fzf('n', "<leader>LG", "live_grep_resume", { desc = "Live grep resume",
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
})

map_fzf('n', "<leader>tm", "tmux_buffers",           { desc = "tmux buffers" })

-- Config files
map_fzf('n', "<leader>yf", "files",
    { desc = "Grep current word",
      cwd = '~/config',
        winopts = {
            preview = { vertical = "down:65%", horizontal = "right:75%", }
        },
    })

map_fzf('n', '<leader>fh', "oldfiles", function()
  return {
    desc = 'file history (cwd)',
    cwd = vim.loop.cwd(),
    show_cwd_header = true,
    cwd_only = true,
    winopts = {
        preview = { vertical = "down:65%", horizontal = "right:75%", }
    },
  }
end)

-- LSP
map_fzf('n', "<leader>lS", "lsp_workspace_symbols",   { desc = "Workspace symbols" })
map_fzf('n', "<leader>ls", "lsp_document_symbols",    { desc = "Document symbols" })
map_fzf('n', "<leader>lr", "lsp_references",          { desc = "LSP references" })
map_fzf('n', "<leader>ld", "lsp_definitions",         { desc = "LSP definitinos" })
map_fzf('n', "<leader>lD", "lsp_declarations",         { desc = "LSP declaration" })
map_fzf("n", "<leader>ly", "lsp_typedefs", { desc = "type definitions [LSP]" })

map_fzf('n', "<leader>HT", "help_tags",               { desc = "nvim help tags" })

-- Full screen git status
map_fzf('n', '<leader>gs', "git_status_tmuxZ",
    { desc = "git status (fullscreen)",
        winopts = {
            fullscreen = true,
            preview = {
                vertical = "down:70%",
                horizontal = "right:70%",
            },
        hl = { help_normal = "FzfLuaTitle", }
        }
    })
map_fzf('n', '<leader>gS', "git_status", vim.tbl_extend("force", {show_cwd_header = false},            { desc = "git status" }))
