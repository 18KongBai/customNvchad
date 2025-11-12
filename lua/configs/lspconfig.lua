require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "jsonls", "bashls", "ts_ls", "eslint", "bashls" }
vim.lsp.enable(servers)
