-- js/ts/vue 家族统一策略：prettierd（守护进程，更快）可用时优先，
-- 否则回退 prettier，格式化完成后再跑 eslint_d --fix。
-- 不能写成 { "prettierd", "prettier", "eslint_d", stop_after_first = true }：
-- stop_after_first 作用于整个列表，会导致 eslint_d 永远不执行
local function prettier_then_eslint(bufnr)
  if require("conform").get_formatter_info("prettierd", bufnr).available then
    return { "prettierd", "eslint_d" }
  end
  return { "prettier", "eslint_d" }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css/less 保留 prettier：下方的 --use-tabs 参数 prettierd 不支持
    less = { "prettier", "stylelint" },
    css = { "prettier", "stylelint" },
    html = { "prettier" },
    javascript = prettier_then_eslint,
    javascriptreact = prettier_then_eslint,
    typescript = prettier_then_eslint,
    typescriptreact = prettier_then_eslint,
    vue = prettier_then_eslint,
    json = { "fixjson" },
  },

  format_after_save = {
    lsp_fallback = true,
  },
}

require("conform").setup(options)

require("conform").formatters.prettier = {
  prepend_args = function(_, ctx)
    -- format_after_save 是异步的，必须用 ctx.buf 而不是当前 buffer 的 filetype
    if vim.bo[ctx.buf].filetype == "css" then
      return { "--use-tabs" }
    end
  end,
}
