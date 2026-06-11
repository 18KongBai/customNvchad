return {
  { import = "nvchad.blink.lazyspec" },
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      if not opts.keymap then
        opts.keymap = {}
      end
      opts.keymap["<C-j>"] = { "select_next", "fallback" }
      opts.keymap["<C-k>"] = { "select_prev", "fallback" }
    end,
  },

  {
    "stevearc/conform.nvim",
    -- 只在保存前才需要加载，纯浏览文件的会话不必加载
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    dependencies = {
      -- jsx 注释
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require "Comment"
      local ft = require "Comment.ft"
      ft.scss = { "/*%s*/", "/*%s*/" }
      ft.less = { "/*%s*/", "/*%s*/" }

      -- enable comment
      comment.setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  -- vscode 顶部的winbar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "LspAttach",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  -- Install a plugin
  -- 在插入模式下输入时不会有延迟地转义
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        -- 关闭 terminal 模式下的 jk/jj 映射，
        -- 否则在 lazygit 等终端 UI 中快速按 jk 会被踢出 terminal 模式
        mappings = {
          t = { j = { k = false, j = false }, k = { j = false } },
        },
      }
    end,
  },

  -- 使用 ripgrep 在当前缓冲区中搜索并替换
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {
      popupWin = {
        title = " 替换",
        border = "single",
        matchCountHlGroup = "Keyword",
        noMatchHlGroup = "ErrorMsg",
        hideSearchReplaceLabels = false,
        position = "bottom", -- "top"|"bottom"
      },
      keymaps = {
        -- normal & visual mode
        confirm = "<CR>",
        abort = "<esc>",
        prevSubst = "<Up>",
        nextSubst = "<Down>",
        openAtRegex101 = "R",
        insertModeConfirm = "<C-CR>", -- (except this one, obviously)
      },
    },
    config = function(_, opts)
      require("rip-substitute").setup(opts)
    end,
  },

  -- 全局搜索替换
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    config = function()
      require("grug-far").setup {}
    end,
  },

  -- 折叠插件
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        opts = function()
          local builtin = require "statuscol.builtin"
          return {
            relculright = true,
            segments = {
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
              { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
          }
        end,
        config = function(_, opts)
          require("statuscol").setup(opts)
        end,
      },
    },
    config = true,
  },

  -- 滚动插件
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    config = true,
  },

  -- 复制功能
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
    config = true,
  },

  -- todo
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- 之前只有 cmd 触发，导致 buffer 里的 TODO/FIXME 高亮在执行命令前完全不生效
    event = "User FilePost",
    cmd = { "TodoTelescope" },
    config = true,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        init = function()
          vim.notify = require "notify"
        end,
        opts = function()
          return require "configs.notifyConfig"
        end,
        config = function(_, opts)
          require("notify").setup(opts)
        end,
      },
    },
    opts = function()
      return require "configs.noiceConfig"
    end,
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },

  -- lsp增强
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    opts = function()
      return require "configs.lspsagaConfig"
    end,
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },

  -- 代码预览图
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    config = true,
  },

  -- 在Neovim中显示图片
  {
    "3rd/image.nvim",
    version = false, -- 使用最新版本
    event = {
      { event = "BufReadPre", pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" } },
      { event = "FileType", pattern = { "markdown", "vimwiki", "norg", "typst" } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-neotest/nvim-nio",
        version = false,
      },
    },
    opts = function()
      return require "configs.imageConfig"
    end,
    config = function(_, opts)
      require("image").setup(opts)
    end,
  },

  -- markdown 编辑器内渲染：标题、表格、代码块、勾选框等直接美化显示，
  -- 光标所在行 / 插入模式自动还原为源码；:RenderMarkdown toggle 可整体开关
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      -- 未安装 latex parser，显式关闭避免 checkhealth 警告
      latex = { enabled = false },
      -- 普通模式下光标行也保持渲染，只在进入插入模式时显示源码
      anti_conceal = { enabled = false },
      win_options = {
        concealcursor = { rendered = "n" },
      },
    },
  },

  -- git插件管理
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- 光标跳转插件
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    event = "VeryLazy",
  },

  -- GitHub Copilot 代码提示（幽灵文本模式，不依赖 nvim-cmp）
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          -- 按键沿用原 codeium 习惯；无建议时按键自动回退默认行为
          keymap = {
            accept = "<A-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-;>",
            prev = "<C-,>",
            dismiss = "<C-x>",
          },
        },
        -- 补全菜单由 blink.cmp 负责，关闭 Copilot 自带面板
        panel = { enabled = false },
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    opts = function()
      -- 对于react中需要加入html代码片段
      -- 对于vue需要支持js,ts,html,css
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })
      luasnip.filetype_extend("vue", { "javascript", "typescript", "html", "css" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        init = function()
          -- nvim-tree 支持
          vim.g.nvim_tree_respect_buf_cwd = 1
        end,
        opts = {
          detection_methods = { "pattern" },
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
        },
        config = function(_, opts)
          require("project_nvim").setup(opts)
        end,
      },
    },
    opts = function(_, opts)
      local extensions = { "yank_history", "projects" }
      for i = #extensions, 1, -1 do
        table.insert(opts.extensions_list, 1, extensions[i])
      end
      opts.defaults.mappings = require("configs.telescope").mappings
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.respect_buf_cwd = true
      opts.update_focused_file = {
        enable = true,
        update_root = true,
      }
      opts.on_attach = require("configs.nvim-tree").on_attach
      opts.view = vim.tbl_deep_extend("force", opts.view or {}, {
        preserve_window_proportions = true,
        width = {
          min = 35,
          max = 60,
          padding = 2,
        },
      })
      opts.renderer = vim.tbl_deep_extend("force", opts.renderer or {}, {
        group_empty = true,
        full_name = true,
        root_folder_label = false,
        indent_width = 1,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    -- 包清单不需要在这里维护：mason.nvim 没有 ensure_installed 选项，
    -- NvChad 的 :MasonInstallAll 会从 lspconfig 启用的 servers 和 conform 的
    -- formatters 自动推导；额外的包写到 chadrc.lua 的 mason.pkgs
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- autotag 由 nvim-ts-autotag 自身的 plugin/ 自动初始化，
    -- 旧式的 opts.autotag 配置已不再被读取
    dependencies = { "windwp/nvim-ts-autotag" },
    opts = {
      ensure_installed = {
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "json",
        "jsonc",
        "yaml",
        "lua",
        "vim",
        "bash",
        "regex",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
