local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    less = { "prettier", "stylelint" },
    css = { "prettier", "stylelint" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier", "eslint_d" },
    typescript = { "prettierd", "prettier", "eslint_d" },
    javascriptreact = { "prettierd", "prettier", "eslint_d" },
    typescriptreact = { "prettierd", "prettier", "eslint_d" },
    vue = { { "prettierd", "prettier", "eslint_d" } },
    json = { "fixjson" },
  },

  --[[ format_on_save = {
    timeout_ms = 600,
    lsp_fallback = true,
  }, ]]
  format_after_save = {
    lsp_fallback = true,
  },
}

require("conform").setup(options)

--[[ require("conform").formatters.prettier = {
  prepend_args = function(self, ctx)
    -- 获取当前缓冲区的文件类型
    local filetype = vim.bo.filetype
    if filetype == "css" then
      -- 向配置中添加特定于CSS的设置
      return { "--use-tabs" }
    end
  end,
} ]]
