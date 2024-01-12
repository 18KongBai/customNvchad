local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- Lua
  b.formatting.stylua,
  -- web 格式化
  -- b.formatting.prettierd,
  b.formatting.prettierd.with { -- 只比默认配置少了 markdown
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
    },
    prefer_local = "node_modules/.bin",
  },
  b.formatting.stylelint,
  -- b.formatting.eslint_d,
  -- 一个 JSON 文件修复器/格式化器，供人类使用（宽松的）JSON5。
  b.formatting.fixjson,

  -- Diagnostics  ---------------------
  --  Diagnostic 就是类似代码行旁边的红字错误提示。
  -- b.diagnostics.eslint_d.with { diagnostics_format = "#{m} [#{c}]" },
  -- b.diagnostics.stylelint.with { diagnostics_format = "#{m} [#{c}]" },
  -- b.diagnostics.markdownlint,

  -- Code Action 就是这行可以触发的行为，比如有些 ESLint 错误是可以自动 Fix 的，这时候这行代码就有一个 Code Action，后边我再演示。
  b.code_actions.eslint_d,
}

null_ls.setup {
  debug = false,
  sources = sources,
}
