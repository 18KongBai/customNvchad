local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    less = { "prettier", "stylelint" },
    css = { "prettier", "stylelint" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier", },
    typescript = { "prettierd", "prettier", },
    javascriptreact = { "prettierd", "prettier", },
    typescriptreact = { "prettierd", "prettier", },
    vue = { { "prettierd", "prettier", } },
    json = { "fixjson" }
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    async = true,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
