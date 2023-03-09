local autocmd = vim.api.nvim_create_autocmd

-- 新增基础配置项
-- utf8
vim.g.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 14
vim.opt.cursorline = false

-- neovide终端配置
require "custom.neovide"
-- vim.g.transparent_enabled = true
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
autocmd("InsertLeave", {
  callback = require("custom.plugins.configs.im-select").insertLeave,
})

autocmd("InsertEnter", {
  callback = require("custom.plugins.configs.im-select").insertEnter,
})

autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
