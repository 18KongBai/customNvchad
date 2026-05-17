require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "jsonls", "bashls", "ts_ls", "eslint", "tailwindcss" }
vim.lsp.enable(servers)

-- 过滤指定 LSP 发出的 "can be written as ..." 简写建议诊断
local function filter_shorthand_diagnostics(server_name)
  vim.lsp.config(server_name, {
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          result.diagnostics = vim.tbl_filter(function(d)
            return not (d.message and d.message:match("can be written as"))
          end, result.diagnostics)
        end
        return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end,
    },
  })
end

filter_shorthand_diagnostics("tailwindcss")
filter_shorthand_diagnostics("eslint")

-- Tailwind CSS v4 兼容配置
vim.lsp.config("tailwindcss", {
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.ts",
    "tailwind.config.cjs",
    "package.json",
  },
  -- 显式声明文件类型，默认不包含 JSX/TSX
  filetypes = {
    "html", "css", "postcss",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "vue", "svelte",
  },
  settings = {
    tailwindCSS = {
      -- 让 LSP 知道在哪些属性中提供补全
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      experimental = {
        classRegex = {
          -- 支持 clsx / cn / cva 等工具函数
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
    },
  },
})

