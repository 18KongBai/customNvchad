require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- n mode
map("n", "<C-j>", "5j", { desc = "向下移动5行" })
map("n", "<C-k>", "5k", { desc = "向上移动5行" })
map("n", "s", "", { desc = "取消s默认功能" })

map("n", "<A-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<A-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<A-k>", "<C-w>k", { desc = "switch window up" })

-- 分屏操作
map("n", "sv", "<cmd>vsp<CR>", { desc = "水平分屏" })
map("n", "sh", "<cmd>sp<CR>", { desc = "垂直分屏" })
map("n", "sc", "<C-w>c", { desc = "关闭窗口" })
map("n", "s,", "<cmd>vertical resize -2<CR>", { desc = "窗口宽度减少" })
map("n", "s.", "<cmd>vertical resize +2<CR>", { desc = "窗口宽度增加" })

map("n", "<leader>w", "<cmd> w <CR>", { desc = "保存当前页面" })
map("n", "<leader>wa", "<cmd> wa <CR>", { desc = "保存所有页面" })
map("n", "<leader>q", "<cmd> qa! <CR>", { desc = "不保存退出" })

map("n", ";", ":", { desc = "CMD enter command mode" })

map("x", "J", ":move '>+1<CR>gv-gv", { desc = "v模式下向下移动代码" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "v模式下向上移动代码" })

map("v", "<C-j>", "5j", { desc = "v模式向下移动5行" })
map("v", "<C-k>", "5k", { desc = "v模式向上移动5行" })

-- nvimtree
map("n", "<A-m>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })

-- tabufline
map("n", "<C-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<C-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "<C-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

-- leap
map("n", "f", "<Plug>(leap-forward)", { desc = "开启leap搜索启动键" })
map("n", "F", "<Plug>(leap-backward)", { desc = "leap向上搜索" })

-- todo
map("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "打开todo列表" })

-- ufo 折叠
map("n", "zR", function()
  require("ufo").closeAllFolds()
end, { desc = "折叠全部" })

map("n", "zM", function()
  require("ufo").openAllFolds()
end, { desc = "显示全部折叠" })

-- telescope
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "telescope find projects" })

-- yanky
map("n", "<leader>p", "<cmd>Telescope yank_history<CR>", { desc = "yank_history" })
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutAfter)<Plug>(YankyPreviousEntry)")
map("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "粘贴后上一个拷贝" })
map("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "粘贴后下一个拷贝" })

-- symbols-outline.nvim
map("n", "<leader>sy", "<cmd>SymbolsOutline<CR>", { desc = "Toggle symbols outline" })

-- lspsaga
map("n", "gp", "<cmd>Lspsaga finder<CR>", { desc = "Lsp finder" })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "lsp hover_doc" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "diagnostic_jump_prev" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "diagnostic_jump_next" })

-- 重命名
map({ "n", "x" }, "<leader>rn", function()
  require("rip-substitute").sub()
end, { desc = "当前替换" })

map("n", "<leader>rl", "<cmd>GrugFar<CR>", { desc = "全局替换" })
