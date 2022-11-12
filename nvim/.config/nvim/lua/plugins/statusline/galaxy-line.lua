local status_ok, gl = pcall(require, 'galaxyline')
if not status_ok then
	print("Couldn't load 'galaxyline'")
	return
end

local gls = gl.section
gl.short_line_list = {}
local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')
local fileinfo = require('galaxyline.provider_fileinfo')

local colors = {
  fg = '#282c34',
  bg = '#282c34',
  -- bg = '#081633',
  magenta = '#d16d9e',
  red = '#ff5370',
  darkblue = '#081633',
  error_red = '#BE5046',
  green = '#C3E88D',
  light_green = '#B5CEA8',
  yellow = '#ffcb6b',
  dark_yellow = '#F78C6C',
  orange = '#CE9178',
  blue = '#82b1ff',
  light_blue = '#9CDCFE',
  vivid_blue = '#4FC1FF',
  purple = '#c792ea',
  blue_purple = '#939ede',
  cyan = '#89DDFF',
  white = '#bfc7d5',
  black = '#292D3E',
  line_grey = '#697098',
  gutter_fg_grey = '#4B5263',
  cursor_grey = '#2C323C',
  visual_grey = '#3E4452',
  menu_grey = '#3E4452',
  special_grey = '#3B4048',
  comment_grey = '#697098',
  vertsplit = '#181A1F',

  l_green = "#A1EFD3",
  l_red = "#ff5370",
  onedark_visual_grey="#3E4452",
}

local signs = {
    right_sepr = '',
    left_sepr = ''
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return '▋' end,
    highlight = {colors.purple,colors.purple}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',v= 'VISUAL',V= 'VISUAL LINE', [''] = 'VISUAL BLOCK'}
      return alias[vim.fn.mode()]
    end,
    separator = signs.right_sepr .. ' ',
    separator_highlight = {colors.purple,function()
      if not buffer_not_empty() then
        return colors.purple
      end
      return colors.darkblue
    end},
    highlight = {colors.darkblue,colors.purple,'bold'},
  },
}

gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
  },
}
gls.left[4] = {
  FileName = {
    provider = {'FileName'},
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.darkblue, colors.green},
    highlight = {colors.magenta,colors.darkblue}
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.darkblue,colors.green},
  }
}
gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.green,colors.onedark_visual_grey},
    highlight = {colors.bg,colors.green},
  }
}

gls.left[7] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.onedark_visual_grey}
  }
}

gls.left[8] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.blue, colors.onedark_visual_grey},
  }
}

-- gls.mid[1] ={
--   Whitespace = {
--     provider = function() return '' end,
--     condition = buffer_not_empty,
--     highlight = {colors.l_green,colors.onedark_visual_grey},
--   },
-- }

-- gls.mid[2] ={
--   FileIcon = {
--     provider = 'FileIcon',
--     condition = buffer_not_empty,
--     highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.red},
--   },
-- }

-- gls.mid[3] = {
--  FilePath = {
--    provider = 'FilePath',
--    condition = buffer_not_empty,
--    highlight = {colors.black,colors.l_green}
--  }
-- }


gls.right[1] = {
  GetLspClient = {
    provider = lspclient.get_lsp_client,
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.black, colors.onedark_visual_grey},
    highlight = {colors.yellow,colors.black},
  },
}

gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = '',
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.black,colors.purple},
  },
}

gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = '',
    separator_highlight = {colors.darkblue,colors.purple},
    highlight = {colors.grey,colors.darkblue},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}
