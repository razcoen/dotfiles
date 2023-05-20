require("mason").setup()
local lsp_handlers = require('lsp.handlers')

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup { automatic_installation = true }

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  lsp_handlers.fix_helm(bufnr)
end

mason_lspconfig.setup_handlers {
  -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
  function(server_name)
    lspconfig[server_name].setup { on_attach = on_attach, }
  end,
}

require('lsp_extensions').inlay_hints {
  highlight = "Comment",
  prefix = " > ",
  aligned = false,
  only_current_line = false,
  enabled = { "TypeHint", "ChainingHint", "ParameterHint" }
}

lsp_handlers.setup()
