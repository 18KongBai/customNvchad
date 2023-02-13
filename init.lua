local autocmd = vim.api.nvim_create_autocmd

local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

-- 新增基础配置项
-- jkhl 移动时光标周围保留8行
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 14
vim.opt.cursorline = false
require('custom.neovide')
-- vim.g.transparent_enabled = true
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
autocmd("InsertLeave", {
  group = myAutoGroup,
  callback = require("custom.plugins.im-select").insertLeave,
})
autocmd("InsertEnter", {
  group = myAutoGroup,
  callback = require("custom.plugins.im-select").insertEnter,
})
autocmd("BufWritePre", {
  group = myAutoGroup,
  -- pattern = { "*.lua", "*.py", "*.sh" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
