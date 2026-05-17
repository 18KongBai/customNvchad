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

  require "configs.opencode",

  {
    "stevearc/conform.nvim",
    event = "BufReadPost",
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

  -- git显示历史提交记录
  {
    "APZelos/blamer.nvim",
    cmd = { "BlamerToggle" },
    keys = {
      { "<leader>bt", "<cmd>BlamerToggle<CR>", desc = "开启历史提交记录" },
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

  -- codeium / windsurf 代码提示（Lua 原生新版，原 codeium.nvim）
  {
    "Exafunction/windsurf.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codeium").setup {
        enable_chat = true,
        virtual_text = {
          enabled = true,
          manual = false,
          idle_delay = 75,
          -- 关闭插件自带按键，下面统一用 vim.keymap.set 设置
          key_bindings = {
            accept = false,
            accept_word = false,
            accept_line = false,
            clear = false,
            next = false,
            prev = false,
          },
        },
      }

      local vt = require "codeium.virtual_text"
      vim.keymap.set("i", "<c-;>", function() vt.cycle_completions(1) end, { desc = "codeium next" })
      vim.keymap.set("i", "<c-,>", function() vt.cycle_completions(-1) end, { desc = "codeium prev" })
      vim.keymap.set("i", "<c-x>", function() vt.clear() end, { desc = "codeium clear" })
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
      opts.system_open = {
        -- cmd = isWSL() and "wsl-open" or "open",
        cmd = "open",
      }
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
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "emmet-ls",
        "json-lsp",
        "eslint_d",
        "fixjson",
        "prettierd",
        "stylelint-lsp",
        "vtsls",
        "markdownlint",
        "vim-language-server",
        "vue-language-server",
        "tailwindcss-language-server",
      },
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
    dependencies = { "windwp/nvim-ts-autotag" },
    opts = {
      autotag = {
        enable = true,
      },
      ensure_installed = {
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "json",
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
