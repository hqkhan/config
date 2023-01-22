-- backward compat
local client_has_capability = function(client, capability)
  local resolved_capabilities = {
    codeLensProvider = 'code_len',
    documentFormattingProvider = 'document_formatting',
    documentRangeFormattingProvider = 'document_range_formatting',
  }
  if vim.fn.has("nvim-0.8") == 1 then
    return client.server_capabilities[capability]
  else
    assert(resolved_capabilities[capability])
    capability = resolved_capabilities[capability]
    return client.resolved_capabilities[capability]
  end
end

local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts,
    { silent = true, buffer = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

local on_attach = function(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes  = 100
  end


  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set("n", "gS", vim.lsp.buf.document_symbol, keymap_opts)
  vim.keymap.set("n", "gs", vim.lsp.buf.workspace_symbol, keymap_opts)

  map('n', '<space>k',  '<cmd>lua vim.lsp.buf.hover()<CR>',
    { desc = "hover information [LSP]" })
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',
    { desc = "goto definition [LSP]" })
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
    { desc = "goto declaration [LSP]" })
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',
    { desc = "goto reference [LSP]" })
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
    { desc = "goto implementation [LSP]" })
  map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    { desc = "goto type definition [LSP]" })
  map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    { desc = "code actions [LSP]" })
  map('v', '<space>rca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>',
    { desc = "range code actions [LSP]" })
  -- use our own rename popup implementation
  map('n', '<leader>lR', '<cmd>lua require("lsp.rename").rename()<CR>',
    { desc = "rename [LSP]" })
  map('n', '<space>K',  '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    { desc = "signature help [LSP]" })
  map('n', '<space>d', '<cmd>lua require("lsp.handlers").peek_definition()<CR>',
    { desc = "peek definition [LSP]" })

  -- using fzf-lua instead
  --map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  --map('n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  map('n', '<leader>lt', "<cmd>lua require'lsp.diag'.toggle()<CR>",
    { desc = "toggle virtual text [LSP]" })

  -- neovim PR #16057
  -- https://github.com/neovim/neovim/pull/16057
  local winopts = "{ float =  { border = 'rounded' } }"
  map('n', '[d', ('<cmd>lua vim.diagnostic.goto_prev(%s)<CR>'):format(winopts),
    { desc = "previous diagnostic [LSP]" })
  map('n', ']d', ('<cmd>lua vim.diagnostic.goto_next(%s)<CR>'):format(winopts),
    { desc = "next diagnostic [LSP]" })
  map('n', '<leader>lc', '<cmd>lua vim.diagnostic.reset()<CR>',
    { desc = "clear diagnostics [LSP]" })
  map('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>',
    { desc = "show line diagnostic [LSP]" })
  map('n', '<leader>lq', '<cmd>lua vim.diagnostic.setqflist()<CR>',
    { desc = "send diagnostics to quickfix [LSP]" })
  map('n', '<leader>lQ', '<cmd>lua vim.diagnostic.setloclist()<CR>',
    { desc = "send diagnostics to loclist [LSP]" })

  if client_has_capability(client, "documentFormattingProvider") then
    -- neovim >= 0.8
    if vim.lsp.buf.format then
      -- get the last attached client name
      -- as most likely null-ls is at [1]
      local clients = vim.lsp.buf_get_clients(bufnr)
      local client_name = clients and clients[#clients].name or client.name
      local fmt_opts = string.format(
        [[async=true,bufnr=%d,name="%s"]], bufnr, client_name)
      map("n", "gq",
        string.format("<cmd>lua vim.lsp.buf.format({%s})<CR>", fmt_opts),
        { desc = string.format("format document [LSP:%s]", client_name) })
    else
      map("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>",
        { desc = "format document [LSP]" })
    end
  end

  if client_has_capability(client, 'documentRangeFormattingProvider') then
    -- neovim >= 0.8
    if vim.lsp.buf.format then
      map('v', 'gq', function()
        local _, csrow, cscol, cerow, cecol
        local mode = vim.fn.mode()
        assert(mode == 'v' or mode == 'V' or mode == '')
        _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
        _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
        if mode == 'V' then
          -- visual line doesn't provide columns
          cscol, cecol = 0, 999
        end
        local fmt_opts = {
          async   = true,
          bufnr   = 0,
          name    = vim.bo[bufnr].ft=="lua" and "sumneko_lua" or nil,
          start   = { csrow, cscol },
          ['end'] = { cerow, cecol },
        }
        vim.lsp.buf.format(fmt_opts)
      end, { desc = "format selection [LSP]" })
    else
      map('v', 'gq', '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
        { desc = "format selection [LSP]" })
    end
  end

  -- if client_has_capability(client, 'codeLensProvider') then
  --   map("n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>",
  --     { desc = "[LSP] code lens" })
  --   vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  -- end

end

return { on_attach = on_attach }
