local actions = require "fzf-lua.actions"

local res, fzf_lua = pcall(require, "fzf-lua")
if not res then
  return
end

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

-- custom devicons setup file to be loaded when `multiprocess = true`
fzf_lua.config._devicons_setup = "~/.config/nvim/lua/plugins/devicons.lua"

fzf_lua.setup {
  fzf_bin            = fzf_bin,
  fzf_colors         = fzf_colors,
  winopts = {
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined)
    height           = 0.98,             -- window height
    width            = 0.85,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.55,            -- window col position (0=left, 1=right)
    preview = {
      layout         = 'horizontal',          -- horizontal|vertical|flex
      flip_columns   = 130,             -- #cols to switch to horizontal on flex
      scrollbar      = 'float',         -- `false` or string:'float|border'
    },
  },
  previewers = {
    bat = {
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
    },
  },
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      ["<C-]>"]        = "toggle-preview-cw",
      ["<C-d>"]        = "preview-page-down",
      ["<C-u>"]        = "preview-page-up",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-p"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
    },
    fzf = {
     -- fzf '--bind=' options
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-p"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["ctrl-d"]      = "preview-page-down",
      ["ctrl-u"]      = "preview-page-up",
    },
  },
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

  -- fzf_bin             = 'sk',        -- use skim instead of fzf?
  fzf_layout          = 'reverse',      -- fzf '--layout='
  fzf_args            = '',             -- adv: fzf extra args, empty unless adv
  preview_border      = 'border',       -- border|noborder
  preview_wrap        = 'nowrap',       -- wrap|nowrap
  preview_opts        = 'nohidden',     -- hidden|nohidden
  preview_vertical    = 'down:65%',     -- up|down:size
  preview_horizontal  = 'right:60%',    -- right|left:size
  preview_layout      = 'vertical',         -- horizontal|vertical|flex
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
    commits = {
      prompt          = 'Commits ❯ ',
      preview_pager   = vim.fn.executable("delta")==1 and "delta --width=$FZF_PREVIEW_COLUMNS --line-numbers",
      actions = {
        ["default"] = actions.git_checkout,
        ["ctrl-e"] = function(selected)
              local commit_hash = selected[1]:match("[^ ]+")
              local cmd = "vsp | Gedit " .. commit_hash .. ":%"
              vim.cmd(cmd)
        end,
        ["ctrl-v"] = function(selected)
              local commit_hash = selected[1]:match("[^ ]+")
              local cmd = "Gvdiffsplit " .. commit_hash .. ":%"
              vim.cmd(cmd)
        end
      },
    },
    bcommits = {
      prompt          = 'BCommits ❯ ',
      preview_pager   = vim.fn.executable("delta")==1 and "delta --width=$FZF_PREVIEW_COLUMNS --line-numbers",
      actions = {
        ['default'] = actions.git_checkout,
        ["ctrl-e"] = function(selected)
              local commit_hash = selected[1]:match("[^ ]+")
              local cmd = "vsp | Gedit " .. commit_hash .. ":%"
              vim.cmd(cmd)
        end,
        ["ctrl-v"] = function(selected)
              local commit_hash = selected[1]:match("[^ ]+")
              local cmd = "Gvdiffsplit " .. commit_hash .. ":%"
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
    },
  },
  grep = {
    prompt            = 'Rg ❯ ',
    input_prompt      = 'Grep For ❯ ',
    rg_opts           = "--hidden --column --line-number --no-heading " ..
                        "--color=always --smart-case -g '!{.git,node_modules,.ccls-cache}/*'",
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
    show_unlisted     = true,         -- include 'help' buffers
    no_term_buffers   = false,        -- include 'term' buffers
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--with-nth"]  = '3..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit,
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

local M = {}
function M.git_status_tmuxZ(opts)
  local function tmuxZ()
    vim.cmd("!tmux resize-pane -Z")
  end
  opts = opts or {}
  opts.fn_pre_win = function(_)
    if not opts.__want_resume then
      -- new fzf window, set tmux Z
      -- add small delay or fzf
      -- win gets wrong dimensions
      tmuxZ()
      vim.cmd("sleep! 20m")
    end
    opts.__want_resume = nil
  end
  opts.fn_post_fzf = function(_, s)
    opts.__want_resume = s and (s[1] == 'left' or s[1] == 'right')
    if not opts.__want_resume then
      -- resume asked do not resize
      -- signals fn_pre to do the same
      tmuxZ()
    end
  end
  fzf_lua.git_status(opts)
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require('fzf-lua')[k]
    end
  end,
})
