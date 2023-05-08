local autocmd = vim.api.nvim_create_autocmd

-- 新增基础配置项
-- utf8
vim.g.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 14
vim.opt.cursorline = false

-- 开启代码折叠
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevelstart = 99

-- indent_blankline
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- nvim-tree 支持
-- vim.g.nvim_tree_respect_buf_cwd = 1

-- neovide终端配置
require "custom.neovide"
-- vim.g.transparent_enabled = true
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
autocmd("InsertLeave", {
  callback = require("custom.configs.im-select").insertLeave,
})

autocmd("InsertEnter", {
  callback = require("custom.configs.im-select").insertEnter,
})

autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
