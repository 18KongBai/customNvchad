local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"
nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "jsonls", "bashls", "ts_ls", "eslint", "bashls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
