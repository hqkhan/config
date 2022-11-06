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
      layout         = 'vertical',          -- horizontal|vertical|flex
      flip_columns   = 130,             -- #cols to switch to horizontal on flex
      scrollbar      = 'float',         -- `false` or string:'float|border'
    },
  },
  previewers = {
    bat = {
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
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
  git = {
    files = {
      winopts = {
        preview = { vertical = "down:65%", horizontal = "right:75%", }
      },
    },
    commits = {
      preview_pager   = vim.fn.executable("delta")==1 and "delta --width=$FZF_PREVIEW_COLUMNS --line-numbers",
      winopts = {
        preview = { vertical = "down:75%", horizontal = "right:75%", }
      },
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
      winopts = {
        preview = { vertical = "down:75%", horizontal = "right:75%", }
      },
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
    branches          = { winopts = {
      preview         = { vertical = "down:75%", horizontal = "right:75%", }
    }}
  },
  grep = {
    rg_opts           = "--hidden --column --line-number --no-heading " ..
                        "--color=always --smart-case -g '!{.git,node_modules,.ccls-cache}/*'",
  },
  lsp                 = { symbols = { path_shorten=1 } },
  diagnostics         = { file_icons=false, icon_padding=' ', path_shorten=1 }
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
