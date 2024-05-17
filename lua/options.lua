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

-- local homePath = vim.fn.expand "$HOME"
-- local snipmate_snippets_path = homePath .. "/.vscode/extensions/bang.antd-snippets-1.2.0/snippets"
-- -- vim.notify(snipmate_snippets_path)
-- vim.g.snipmate_snippets_path = snipmate_snippets_path
