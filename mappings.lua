-- lua/custom/mappings
local M = {}

-- add this table only when you want to disable default keys
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-s>"] = ""
--   }
-- }

-- n, v, i, t = mode names

M.general = {
  v = {
    ["<C-j>"] = { "5j", "向下移动5行" },
    ["<C-k>"] = { "5k", "向上移动5行" },
  },
  n = {
    ["<C-s>"] = { "", "" },
    ["s"] = { "", "取消s默认功能" },
    -- 分屏操作
    ["sv"] = { ":vsp<CR>", "水平分屏" },
    ["sh"] = { ":sp<CR>", "垂直分屏" },
    ["sc"] = { "<C-w>c", "关闭窗口" },
    ["s,"] = { ":vertical resize -2<CR>", "窗口宽度减少" },
    ["s."] = { ":vertical resize +2<CR>", "窗口宽度增加" },
    -- switch between windows
    ["<A-h>"] = { "<C-w>h", "window left" },
    ["<A-l>"] = { "<C-w>l", "window right" },
    ["<A-j>"] = { "<C-w>j", "window down" },
    ["<A-k>"] = { "<C-w>k", "window up" },
    -- save
    ["<leader>w"] = { "<cmd> w <CR>", "保存当前页面" },
    ["<leader>wa"] = { "<cmd> wa <CR>", "保存所有页面" },
    ["<leader>q"] = { "<cmd> qa! <CR>", "不保存退出" },
    ["<C-j>"] = { "5j", "向下移动5行" },
    ["<C-k>"] = { "5k", "向上移动5行" },
    ["<leader>tp"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "更改透明度",
    },
  },
  x = {
    ["J"] = { ":move '>+1<CR>gv-gv", "v模式下向下移动代码" },
    ["K"] = { ":move '<-2<CR>gv-gv", "v模式下向上移动代码" },
  },
  c = {
    ["<C-j>"] = { "<C-n>", "下一个" },
    ["<C-k>"] = { "<C-p>", "上一个" },
  },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["<C-l>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "下一个标签",
    },
    ["<C-h>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "上一个标签页",
    },
    -- 取消nvchad默认按键功能
    ["<S-tab>"] = { "", "" },
    ["<leader>x"] = { "", "" },
    -- close buffer + hide terminal buffer
    ["<C-w>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "关闭当前页面",
    },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<A-m>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<C-n>"] = { "" },
    ["<leader>e"] = { "" },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>sk"] = { "<cmd> Telescope keymaps <CR>", "展示按键映射" },
  },
}

M.terminal = {
  n = {
    -- spawn new terms
    ["<leader>h"] = { "" },
    ["<leader>v"] = { "" },
    ["<A-h>"] = { "<C-w>h", "window left" },
  },
}

M.lazygit = {
  n = {
    ["<leader>gg"] = {
      "<cmd>LazyGit<CR>",
    },
  },
}

M.blamer = {
  n = {
    ["<leader>gb"] = {
      "<cmd>BlamerToggle<CR>",
      "是否展示git提交记录",
    },
  },
}

-- M.lspconfig = {
--   n = {
--     ["<leader>rn"] = {
--       function()
--         require("nvchad.renamer").open()
--       end,
--       "LSP rename",
--     },
--     ["<leader>ca"] = {
--       "<cmd>Lspsaga code_action<CR>",
--       "code action",
--     },
--     ["gh"] = {
--       "<cmd>Lspsaga hover_doc<CR>",
--       "hover Doc",
--     },
--     ["ge"] = {
--       "<cmd>Lspsaga show_line_diagnostics<CR>",
--       "Show line diagnostics",
--     },
--     ["gj"] = {
--       "<cmd>Lspsaga diagnostic_jump_next<cr>",
--       "Lspsaga diagnostic_jump_next",
--     },
--     ["gk"] = {
--       "<cmd>Lspsaga diagnostic_jump_prev<cr>",
--       "Lspsaga diagnostic_jump_prev",
--     },
--     ["gf"] = {
--       "<cmd>Lspsaga finder<CR>",
--       "lspsaga finder",
--     },
--     ["gp"] = {
--       "<cmd>Lspsaga peek_definition<cr>",
--       "lspsaga peek_definition",
--     },
--   },
-- }

M.leap = {
  n = {
    ["f"] = {
      "<Plug>(leap-forward)",
      "开启leap搜索启动键",
    },
    ["F"] = {
      "<Plug>(leap-backward)",
      "leap向上搜索",
    },
  },
}

M.todo = {
  n = {
    ["<leader>td"] = {
      "<cmd>TodoTelescope<CR>",
      "打开todo列表",
    },
  },
}

M.ufo = {
  n = {
    ["K"] = {
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      "显示折叠内容",
    },
    ["zr"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "折叠全部",
    },
    ["zm"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "显示全部折叠",
    },
  },
}

return M
