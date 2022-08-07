local actions = require "fzf-lua.actions"

-- return first matching highlight or nil
local function hl_match(t)
  for _, h in ipairs(t) do
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, h, true)
    -- must have at least bg or fg, otherwise this returns
    -- succesffully for cleared highlights (on colorscheme switch)
    if ok and (hl.foreground or hl.background) then
      return h
    end
  end
end

local fzf_colors = function(opts)
  local binary = opts and opts.fzf_bin
  local colors = {
    ["fg"] = { "fg", "Normal" },
    ["bg"] = { "bg", "Normal" },
    ["hl"] = { "fg", hl_match({ "NightflyViolet", "Directory" }) },
    ["fg+"] = { "fg", "Normal" },
    ["bg+"] = { "bg", hl_match({ "NightflyVisual", "CursorLine" }) },
    ["hl+"] = { "fg", "CmpItemKindVariable" },
    ["info"] = { "fg", hl_match({ "NightflyPeach", "WarningMsg" }) },
    -- ["prompt"] = { "fg", "SpecialKey" },
    ["pointer"] = { "fg", "DiagnosticError" },
    ["marker"] = { "fg", "DiagnosticError" },
    ["spinner"] = { "fg", "Label" },
    ["header"] = { "fg", "Comment" },
    ["gutter"] = { "bg", "Normal" },
  }
  if binary == 'sk' and vim.fn.executable(binary) == 1 then
    colors["matched_bg"] = { "bg", "Normal" }
    colors["current_match_bg"] = { "bg", hl_match({ "NightflyVisual", "CursorLine" }) }
  end
  return colors
end

require'fzf-lua'.setup {
  fzf_colors         = fzf_colors,
  winopts = {
    -- split         = "belowright new",-- open in a split instead?
                                        -- "belowright new"  : split below
                                        -- "aboveleft new"   : split above
                                        -- "belowright vnew" : split right
                                        -- "aboveleft vnew   : split left
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined)
    height           = 0.85,            -- window height
    width            = 0.80,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.50,            -- window col position (0=left, 1=right)
    -- border argument passthrough to nvim_open_win(), also used
    -- to manually draw the border characters around the preview
    -- window, can be set to 'false' to remove all borders or to
    -- 'none', 'single', 'double' or 'rounded' (default)
    border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    fullscreen       = false,           -- start fullscreen?
    hl = {
      normal         = 'Normal',        -- window normal color (fg+bg)
      border         = 'Normal',        -- border color (try 'FloatBorder')
      -- Only valid with the builtin previewer:
      cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
      cursorline     = 'CursorLine',    -- cursor line
      -- title       = 'Normal',        -- preview border title (file/buffer)
      -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
      -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
    },
    preview = {
      -- default     = 'bat',           -- override the default previewer?
                                        -- default uses the 'builtin' previewer
      border         = 'border',        -- border|noborder, applies only to
                                        -- native fzf previewers (bat/cat/git/etc)
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:45%',      -- up|down:size
      horizontal     = 'right:60%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = 120,             -- #cols to switch to horizontal on flex
      -- Only used with the builtin previewer:
      title          = true,            -- preview border title (file/buf)?
      scrollbar      = 'float',         -- `false` or string:'float|border'
                                        -- float:  in-window floating border
                                        -- border: in-border chars (see below)
      scrolloff      = '-2',            -- float scrollbar offset from right
                                        -- applies only when scrollbar = 'float'
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
                                        -- applies only when scrollbar = 'border'
      delay          = 100,             -- delay(ms) displaying the preview
                                        -- prevents lag on fast scrolling
      winopts = {                       -- builtin previewer window options
        number            = true,
        relativenumber    = false,
        cursorline        = true,
        cursorlineopt     = 'both',
        cursorcolumn      = false,
        signcolumn        = 'no',
        list              = false,
        foldenable        = false,
        foldmethod        = 'manual',
      },
    },
  },
  previewers = {
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
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- uncomment if you wish to use git-delta as pager
      -- can also be set under 'git.status.preview_pager'
      -- pager        = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    man = {
      -- NOTE: remove the `-c` flag when using man-db
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
      -- preview extensions using a custom shell command:
      -- for example, use `viu` for image previews
      -- will do nothing if `viu` isn't executable
      extensions      = {
        -- neovim terminal only supports `viu` block output
        ["png"]       = { "viu", "-b" },
        ["jpg"]       = { "ueberzug" },
      },
      -- if using `ueberzug` in the above extensions map
      -- set the default image scaler, possible scalers:
      --   false (none), "crop", "distort", "fit_contain",
      --   "contain", "forced_cover", "cover"
      -- https://github.com/seebye/ueberzug
      ueberzug_scaler = "cover",
    },
  },
    on_create = function()
      -- called once upon creation of the fzf main window
      -- can be used to add custom fzf-lua mappings, e.g:
      --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
      --     { silent = true, noremap = true })
    end,
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
     -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
    },
  },
  -- use skim instead of fzf?
  -- https://github.com/lotabout/skim
  -- fzf_bin          = 'sk',
  fzf_opts = {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--height']      = '100%',
    ['--layout']      = 'reverse',
    ['--border']      = 'none',
  },
  -- fzf '--color=' options (optional)
  --[[ fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Comment" },
      ["fg+"] = { "fg", "Normal" },
      ["bg+"] = { "bg", "CursorLine" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Exception" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
  }, ]] 

  -- fzf_bin             = 'sk',        -- use skim instead of fzf?
  fzf_layout          = 'reverse',      -- fzf '--layout='
  fzf_args            = '',             -- adv: fzf extra args, empty unless adv
  preview_border      = 'border',       -- border|noborder
  preview_wrap        = 'nowrap',       -- wrap|nowrap
  preview_opts        = 'nohidden',     -- hidden|nohidden
  preview_vertical    = 'down:45%',     -- up|down:size
  preview_horizontal  = 'right:60%',    -- right|left:size
  preview_layout      = 'flex',         -- horizontal|vertical|flex
  flip_columns        = 120,            -- #cols to switch to horizontal on flex
  -- default_previewer   = "bat",       -- override the default previewer?
                                        -- by default uses the builtin previewer
  -- provider setup
  files = {
    -- previewer         = "cat",       -- uncomment to override previewer
    prompt            = 'Files ❯ ',
    -- cmd               = '',             -- "find . -type f -printf '%P\n'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    fd_opts           = "--no-ignore --color=never --type f --hidden --follow --exclude .git",
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-q"]      = actions.file_sel_to_qf
    }
  },
  git = {
    files = {
      prompt          = 'GitFiles ❯ ',
      cmd             = 'git ls-files --exclude-standard',
      multiprocess    = true,
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
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
      preview       = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color {1}",
      -- uncomment if you wish to use git-delta as pager
      --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS"
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      prompt          = 'BCommits ❯ ',
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
      -- preview       = "git diff --color {1}~1 {1} -- <file>",
      preview_pager   = vim.fn.executable("delta")==1 and "delta --width=$COLUMNS --line-numbers",

      -- uncomment if you wish to use git-delta as pager
      --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS"
      actions = {
        ['default'] = function(selected, o)
              local commit_hash = selected[1]:match("[^ ]+")
              local cmd = string.format("Gvdiffsplit %s", commit_hash)
              vim.cmd(cmd)
       end
      }
    },
    branches = {
      prompt          = 'Branches ❯ ',
      cmd             = "git branch --all --color",
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
    rg_opts           = "--hidden --column --line-number --no-heading " ..
                        "--color=always --smart-case -g '!{.git,node_modules}/*'",
    multiprocess      = true,
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    rg_glob           = true,
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-g"]      = { actions.grep_lgrep }
    }
  },
  buffers = {
    -- previewer      = false,        -- disable the builtin previewer?
    prompt            = 'Buffers ❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-x"]      = { actions.buf_del, actions.resume }
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
  quickfix = {
    -- cwd               = vim.loop.cwd(),
    file_icons        = true,
    git_icons         = true,
  },
  file_icon_padding = '',
  file_icon_colors = {
    ["lua"]   = "blue",
  },
}

------------------------------------
-------------Keymaps----------------
------------------------------------

-- Find commits for current file

vim.api.nvim_set_keymap('n', '<leader>fc',
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
