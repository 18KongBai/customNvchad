-- lua/custom/mappings
local M = {}

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
-- add this table only when you want to disable default keys
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-s>"] = ""
--   }
-- }

-- n, v, i, t = mode names

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "i模式下跳到行首" },
    ["<C-e>"] = { "<End>", "i模式下跳到行尾" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "i模式下左移" },
    ["<C-l>"] = { "<Right>", "i模式下右移" },
    ["<C-j>"] = { "<Down>", "i模式下下移" },
    ["<C-k>"] = { "<Up>", "i模式下上移" },
  },

  v = {
    ["<C-j>"] = { "5j", "向下移动5行" },
    ["<C-k>"] = { "5k", "向上移动5行" },
  },

  t = { ["<F1>"] = { termcodes "<C-\\><C-N>", "退出终端输入模式" } },

  n = {
    ["<leader>b"] = { "<cmd> enew <CR>", "创建新页面" },
    ["<C-s>"] = { "", "" },
    -- ["s"] = { "", "取消s默认功能" },
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

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "拷贝当前页面" },

    -- line numbers
    ["<leader>sn"] = { "<cmd> set nu! <CR>", "是否展示行号数字" },
    ["<leader>srn"] = { "<cmd> set rnu! <CR>", "是否使用相对行号" },

    -- update nvchad
    ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "更新配置" },

    ["<C-j>"] = { "5j", "向下移动5行" },
    ["<C-k>"] = { "5k", "向上移动5行" },
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
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "下一个标签",
    },

    ["<C-h>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "上一个标签页",
    },
    -- 取消nvchad默认按键功能
    ["<S-Tab>"] = { "", "" },
    ["<leader>x"] = { "", "" },

    -- close buffer + hide terminal buffer
    ["<C-w>"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
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
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "查找文件" },
    ["<C-f>"] = { "<cmd> Telescope live_grep <CR>", "查找关键词" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "查询修改缓存" },
    ["<leader>sk"] = { "<cmd> Telescope keymaps <CR>", "展示按键映射" },
    -- pick a hidden term
    -- 选择隐藏的终端
    ["<leader>st"] = { "<cmd> Telescope terms <CR>", "显示隐藏的终端" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "选择主题" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    -- 关闭悬浮终端
    ["<leader>ti"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "切换浮动终端",
    },

    -- 关闭底部终端
    ["<leader>tb"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "切换底部终端",
    },
  },

  n = {
    -- toggle in normal mode
    -- 打开悬浮终端
    ["<leader>ti"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "切换浮动终端",
    },

    -- 打开底部终端
    ["<leader>tb"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "切换底部终端",
    },

    -- new

    -- 新建一个终端
    ["<leader>tnb"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "打开新的底部终端",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "切换注释",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
      "v模式下切换注释",
    },
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

M.lspconfig = {
  n = {
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["<leader>ca"] = {
      "<cmd>Lspsaga code_action<CR>",
      "code action",
    },
    ["gh"] = {
      "<cmd>Lspsaga hover_doc<CR>",
      "hover Doc",
    },
    ["ge"] = {
      "<cmd>Lspsaga show_line_diagnostics<CR>",
      "Show line diagnostics",
    },
    ["gj"] = {
      "<cmd>Lspsaga diagnostic_jump_next<cr>",
      "Lspsaga diagnostic_jump_next",
    },
    ["gk"] = {
      "<cmd>Lspsaga diagnostic_jump_prev<cr>",
      "Lspsaga diagnostic_jump_prev",
    },
    ["gf"] = {
      "<cmd>Lspsaga lsp_finder<CR>",
      "lspsaga finder",
    },
    ["gp"] = {
      "<cmd>Lspsaga peek_definition<cr>",
      "lspsaga peek_definition",
    },
  },
}

M.markdown = {
  n = {
    ["<F5>"] = {
      "<cmd>MarkdownPreview<CR>",
      "打开markdown预览",
    },
  },
}

M.undotree = {
  n = {
    ["<F4>"] = {
      "<cmd>UndotreeToggle<CR>",
      "打开撤销记录",
    },
  },
}

M.todo = {
  n = {
    ["<leader>td"] = {
      "<cmd>TodoTelescope<CR>",
      "打开todo列表",
    },
    ["<leader>["] = {
      function()
        require("todo-comments").jump_prev()
      end,
      "上一个todo记录",
    },
    ["<leader>]"] = {
      function()
        require("todo-comments").jump_next()
      end,
      "下一个todo记录",
    },
  },
}

M.leap = {
  n = {
    ["f"] = {
      "<Plug>(leap-forward)",
      "开启leap搜索启动键",
    },
  },
}

return M
