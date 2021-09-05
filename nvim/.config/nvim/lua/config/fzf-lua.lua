local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  winopts = {
    -- split         = "new",           -- open in a split instead?
    win_height       = 0.85,            -- window height
    win_width        = 0.80,            -- window width
    win_row          = 0.30,            -- window row position (0=top, 1=bottom)
    win_col          = 0.50,            -- window col position (0=left, 1=right)
    -- win_border    = false,           -- window border? or borderchars?
    win_border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    hl_normal        = 'Normal',        -- window normal color
    hl_border        = 'Repeat',        -- window border color
  },
  -- fzf_bin             = 'sk',        -- use skim instead of fzf?
  fzf_layout          = 'reverse',      -- fzf '--layout='
  fzf_args            = '',             -- adv: fzf extra args, empty unless adv
  fzf_binds           = {               -- fzf '--bind=' options
      'f2:toggle-preview',
      'f3:toggle-preview-wrap',
      'shift-down:preview-page-down',
      'shift-up:preview-page-up',
      'ctrl-d:half-page-down',
      'ctrl-u:half-page-up',
      'ctrl-f:page-down',
      'ctrl-b:page-up',
      'ctrl-a:toggle-all',
      'ctrl-l:clear-query',
  },
  preview_border      = 'border',       -- border|noborder
  preview_wrap        = 'nowrap',       -- wrap|nowrap
  preview_opts        = 'nohidden',     -- hidden|nohidden
  preview_vertical    = 'down:45%',     -- up|down:size
  preview_horizontal  = 'right:60%',    -- right|left:size
  preview_layout      = 'flex',         -- horizontal|vertical|flex
  flip_columns        = 120,            -- #cols to switch to horizontal on flex
  -- default_previewer   = "bat",       -- override the default previewer?
                                        -- by default uses the builtin previewer
  previewers = {
    cmd = {
      -- custom previewer, will execute:
      -- `<cmd> <args> <filename>`
      cmd             = "echo",
      args            = "",
    },
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd             = "git diff",
      args            = "--color",
    },
    builtin = {
      title           = true,         -- preview title?
      scrollbar       = true,         -- scrollbar?
      scrollchar      = '█',          -- scrollbar character
      wrap            = false,        -- wrap lines?
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      expand          = false,        -- preview max size?
      hl_cursor       = 'Cursor',     -- cursor highlight
      hl_cursorline   = 'CursorLine', -- cursor line highlight
      hl_range        = 'IncSearch',  -- ranger highlight (not yet in use)
      keymap = {
        toggle_full   = '<F2>',       -- toggle full screen
        toggle_wrap   = '<F3>',       -- toggle line wrap
        toggle_hide   = '<F4>',       -- toggle on/off (not yet in use)
        page_up       = '<S-up>',     -- preview scroll up
        page_down     = '<S-down>',   -- preview scroll down
        page_reset    = '<S-left>',      -- reset scroll to orig pos
      },
    },
  },
  -- provider setup
  files = {
    -- previewer         = "cat",       -- uncomment to override previewer
    prompt            = 'Files ❯ ',
    cmd               = '',             -- "find . -type f -printf '%P\n'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    }
  },
  git = {
    files = {
      prompt          = 'GitFiles ❯ ',
      cmd             = 'git ls-files --exclude-standard',
      git_icons       = true,           -- show git icons?
      file_icons      = true,           -- show file icons?
      color_icons     = true,           -- colorize file|git icons
    },
    status = {
      prompt        = 'GitStatus ❯ ',
      cmd           = "git status -s",
      previewer     = "git_diff",
      file_icons    = true,
      git_icons     = true,
      color_icons   = true,
    },
    commits = {
      prompt          = 'Commits ❯ ',
      cmd             = "git log --pretty=oneline --abbrev-commit --color --reflog",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      prompt          = 'BCommits ❯ ',
      cmd             = "git log --pretty=oneline --abbrev-commit --color --reflog",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      prompt          = 'Branches ❯ ',
      cmd             = "git branch --all --color --reflog",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {
        ["default"] = actions.git_switch,
      },
    },
    icons = {
      ["M"]           = { icon = "M", color = "yellow" },
      ["D"]           = { icon = "D", color = "red" },
      ["A"]           = { icon = "A", color = "green" },
      ["?"]           = { icon = "?", color = "magenta" },
      -- ["M"]          = { icon = "★", color = "red" },
      -- ["D"]          = { icon = "✗", color = "red" },
      -- ["A"]          = { icon = "+", color = "green" },
    },
  },
  grep = {
    prompt            = 'Rg ❯ ',
    input_prompt      = 'Grep For ❯ ',
    -- cmd               = "rg --vimgrep",
    rg_opts           = "--hidden --column --line-number --no-heading " ..
                        "--color=always --smart-case -g '!{.git,node_modules}/*'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    }
  },
  oldfiles = {
    prompt            = 'History ❯ ',
    cwd_only          = false,
  },
  buffers = {
    -- previewer      = false,        -- disable the builtin previewer?
    prompt            = 'Buffers ❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
      ["ctrl-x"]      = actions.buf_del,
    }
  },
  blines = {
    previewer         = "builtin",    -- set to 'false' to disable
    prompt            = 'BLines ❯ ',
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  colorschemes = {
    prompt            = 'Colorschemes ❯ ',
    live_preview      = true,       -- apply the colorscheme on preview?
    actions = {
      ["default"]     = actions.colorscheme,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    },
    winopts = {
      win_height        = 0.55,
      win_width         = 0.30,
    },
    post_reset_cb     = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end,
  },
  quickfix = {
    -- cwd               = vim.loop.cwd(),
    file_icons        = true,
    git_icons         = true,
  },
  lsp = {
    prompt            = '❯ ',
    -- cwd               = vim.loop.cwd(),
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = true,       -- timeout(ms) or false for blocking calls
    file_icons        = true,
    git_icons         = false,
    lsp_icons         = true,
    severity          = "hint",
    icons = {
      ["Error"]       = { icon = "", color = "red" },       -- error
      ["Warning"]     = { icon = "", color = "yellow" },    -- warning
      ["Information"] = { icon = "", color = "blue" },      -- info
      ["Hint"]        = { icon = "", color = "magenta" },   -- hint
    },
  },
  -- placeholders for additional user customizations
  loclist = {},
  helptags = {},
  manpages = {},
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  -- padding can help kitty term users with
  -- double-width icon rendering
  file_icon_padding = '',
  file_icon_colors = {
    ["lua"]   = "blue",
  },
}


------------------------------------
-------------Keymaps----------------
------------------------------------

-- Builtin
vim.api.nvim_set_keymap('n', '<leader>fzf',
    "<cmd>lua require('fzf-lua').builtin()<CR>",
    { noremap = true, silent = true })

 -- Normal files
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

-- Rg
vim.api.nvim_set_keymap('n', '<leader>rg',
    "<cmd>lua require('fzf-lua').grep()<CR>",
    { noremap = true, silent = true })

-- Config
vim.api.nvim_set_keymap('n', '<leader><CR>',
    "<cmd>lua require('fzf-lua').files({ cwd = '~/.config' })<CR>",
    { noremap = true, silent = true })

-- " command! -bang -nargs=* Rg
-- "   \ call fzf#vim#grep(
-- "   \   'rg --column --line-number --no-heading --color=always --follow --smart-case '.shellescape(<q-args>), 1,
-- "   \   fzf#vim#with_preview(), <bang>0)
-- "
