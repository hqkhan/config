-- Return a packer startup function with all necessary plugins
local packer_startup = function(use)

  local function prefer_local(url, path)
    local plug = url:match("[^/]*$")
    local paths = {
      "$HOME/Sources/nvim/" .. plug,
      "/shared/$USER/Sources/nvim/" .. plug,
    }
    -- caller path argument takes precedence
    if path then table.insert(paths, 1, path) end
    for _, p in ipairs(paths) do
      if vim.loop.fs_stat(vim.fn.expand(p)) then
        return p
      end
    end
    return url
  end

  -- speed up 'require', must be the first plugin
  use { "lewis6991/impatient.nvim",
    config = "if vim.fn.has('nvim-0.6')==1 then require('impatient') end"
  }

  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim', opt = true }

  -- SmartYank (by me), load at 'VimEnter' so
  -- it's downloaded to 'site/pack/packer/opt'
  use { prefer_local('ibhagwan/smartyank.nvim'),
    config = "require('plugins.smartyank')",
    event = "VimEnter"
  }

  -- vim-surround/sandwich, lua version
  -- mini also has an indent highlighter
  use { 'echasnovski/mini.nvim',
    config = [[
        require'plugins.surround'
        require'plugins.indent'
        require'mini.ai'.setup()
      ]],
    event = "VimEnter"
  }

  -- "gc" to comment visual regions/lines
  use { 'numToStr/Comment.nvim',
    config = "require('plugins.comment')",
    -- uncomment for lazy loading
    -- slight delay if loading in visual mode
    -- keys = {'gcc', 'gc', 'gl'}
    event = "VimEnter"
  }

  -- needs no introduction
  use { 'https://tpope.io/vim/fugitive.git',
    config = "require('plugins.fugitive')",
    event = "VimEnter"
  }

  -- plenary is required by gitsigns and telescope
  -- lazy load so gitsigns doesn't abuse our startup time
  use { "nvim-lua/plenary.nvim", event = "VimEnter" }

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugins.gitsigns')",
    after = "plenary.nvim" }

  -- 'famiu/nvim-reload' has been archived and no longer maintained
  use { vim.fn.stdpath("config") .. "/lua/plugins/nvim-reload",
    config = "require('plugins.nvim-reload')",
    -- skip this since we manually lazy load
    -- in our command / binding
    -- cmd = { 'NvimReload', 'NvimRestart' },
    -- opt = true,
  }

  -- Autocompletion & snippets
  use { 'L3MON4D3/LuaSnip',
    config = 'require("plugins.luasnip")'
    -- event = 'InsertEnter'
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    },
    config = "require('plugins.cmp')",
    -- event = "InsertEnter", }
  }

  -- nvim-treesitter
  -- verify a compiler exists before installing
  if require 'utils'.have_compiler() then
    use({
      { prefer_local('nvim-treesitter/nvim-treesitter'),
        config = "require('plugins.treesitter')",
        run = ':TSUpdate',
        event = 'BufRead'
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects',
        after = { 'nvim-treesitter' }
      },
      -- debuging treesitter
      { 'nvim-treesitter/playground',
        after = { 'nvim-treesitter' },
        cmd = { 'TSPlaygroundToggle' },
      }
    })
  end

  -- optional for fzf-lua, nvim-tree
  use { 'kyazdani42/nvim-web-devicons',
    config = "require('plugins.devicons')",
    -- event = 'VimEnter'
  }

  -- nvim-tree
  use { 'kyazdani42/nvim-tree.lua',
    config = "require('plugins.nvim-tree')",
    -- cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
  }

  -- only required if you do not have fzf binary
  -- use = { 'junegunn/fzf', run = './install --bin', }
  use { 'ibhagwan/fzf-lua',
    setup = "require('plugins.fzf-lua.mappings')",
    config = "require('plugins.fzf-lua')"
  }

  -- better quickfix
  -- use { 'kevinhwang91/nvim-bqf',
  --   config = "require'plugins.bqf'",
  --   ft = { 'qf' }
  -- }

  -- LSP
  use({
    { 'neovim/nvim-lspconfig', event = 'BufRead' },
    { 'williamboman/nvim-lsp-installer',
      config = "require('lsp')",
      after  = { 'nvim-lspconfig' },
    },
    { 'j-hui/fidget.nvim',
      config = [[require('fidget').setup()]],
      after  = { 'nvim-lspconfig' },
    }
  })

--  use({
--      "jose-elias-alvarez/null-ls.nvim",
--      config = [[
--        require("null-ls").setup({
--          sources = {
--            require("null-ls").builtins.formatting.stylua,
--          },
--        })
--      ]],
--      after  = { 'nvim-lspconfig' },
-- })

  -- key bindings cheatsheet
  -- use { 'folke/which-key.nvim',
  --   config = "require('plugins.which_key')",
  --   event = "VimEnter"
  -- }

-- Colorizer
use { 'nvchad/nvim-colorizer.lua',
    config = "require'colorizer'.setup()",
    cmd = { 'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' },
    -- opt = true
}

-- Install statusline (galaxy)
use{
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = "require('plugins.statusline')",
    requires = {'kyazdani42/nvim-web-devicons'}
}

-- Install bufferline
use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    config = "require('plugins.bufferline')",
    requires = 'kyazdani42/nvim-web-devicons'
}

end

return packer_startup
