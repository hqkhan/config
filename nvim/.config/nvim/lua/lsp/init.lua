-- setup nvim-lsp-installer before interacting with lspconfig
-- https://github.com/williamboman/nvim-lsp-installer/discussions/636
pcall(function()
  require("nvim-lsp-installer").setup({
    ensure_installed = { "sumneko_lua" },
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  })
end)

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

-- Setup icons & handler helper functions
require('lsp.diag')
require('lsp.icons')
require('lsp.handlers')

-- Enable borders for hover/signature help
vim.lsp.handlers['textDocument/hover'] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

local __settings = {}

-- Lua settings
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

__settings['sumneko_lua'] = {
  -- enables sumneko_lua formatting, see:
  -- https://github.com/sumneko/lua-language-server/issues/960
  -- https://github.com/sumneko/lua-language-server/wiki/Code-Formatter
  cmd = { 'lua-language-server', '--preview' },
  -- no need to override 'root_dir' since we added '.config/nvim/.luacheckrc'
  -- root_dir = require'lspconfig.util'.root_pattern(
  --   ".luarc.json", ".luacheckrc", ".stylua.toml", "selene.toml", ".git", ".sumneko_lua"),
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        -- LuaJIT in the case of Neovim
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'describe',     -- busted
          'it'            -- busted
        },
        -- enables formatter warnings
        -- neededFileStatus = { ['codestyle-check'] = "any" }
        disable = {
          -- Need check nil
          "need-check-nil",
          -- This function requires 2 argument(s) but instead it is receiving 1
          "missing-parameter",
          -- Cannot assign `unknown` to `string`.
          "assign-type-mismatch",
          -- Cannot assign `unknown` to parameter `string`.
          "param-type-mismatch",
          -- This variable is defined as type `string`. Cannot convert its type to `unknown`.
          "cast-local-type",
        }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        }
        -- This causes slow init of sumneko_lua
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
      -- disable certain warnings that don't concern us
      -- https://github.com/sumneko/lua-language-server/blob/master/doc/en-us/config.md
      type = {
        -- Cannot assign `string|nil` to parameter `string`.
        weakNilCheck = true,
        weakUnionCheck = true,
        -- Cannot assign `number` to parameter `integer`.
        castNumberToInteger = true,
      },
    }
  }
}

-- use nightly rustfmt if exists
-- https://github.com/rust-lang/rust-analyzer/issues/3627
-- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
__settings['rust_analyzer'] = {
  settings = {
    ["rust-analyzer"] = {
      rustfmt = {
        -- extraArgs = { "+nightly", },
        -- overrideCommand = {
        --   "rustup",
        --   "run",
        --   "nightly",
        --   "--",
        --   "rustfmt",
        --   "--edition",
        --   "2021",
        --   "--",
        -- },
      },
    }
  }
}

__settings['ccls'] = {
  init_options = {
    codeLens = {
      enabled = false,
      renderInline = false,
      localVariables = false,
    }
  }
}


local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- enables snippet support
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- enables LSP autocomplete
  local cmp_loaded, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_loaded then
    capabilities = cmp_lsp.default_capabilities()
  end
  return {
    on_attach = require('lsp.on_attach').on_attach,
    capabilities = capabilities,
  }
end

local servers = {
  'sumneko_lua',
  'rust_analyzer',
  'gopls',
  'pyright',
  'clangd',
  -- 'ccls',
}

local function is_installed(cfg)
  local cmd = cfg.document_config
    and cfg.document_config.default_config
    and cfg.document_config.default_config.cmd or nil
  -- server globally installed?
  if cmd and cmd[1] and vim.fn.executable(cmd[1]) == 1 then
    return true
  end
  -- otherwise, check 'nvim-lsp-installer' path
  local has_cfg, srv = require "nvim-lsp-installer".get_server(cfg.name)
  return has_cfg and srv:is_installed()
end

for _, srv in ipairs(servers) do
  local cfg = make_config()
  if __settings[srv] then
    cfg = vim.tbl_deep_extend("force", __settings[srv], cfg)
  end
  if is_installed(lspconfig[srv]) then
    lspconfig[srv].setup(cfg)
  end
end
