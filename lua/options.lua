require "nvchad.options"

-- 需要 24 位颜色，可以通过将其添加到 init.lua 来启用
vim.opt.termguicolors = true
-- 折叠
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- 折叠
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

vim.opt.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 14
vim.opt.cursorline = false
