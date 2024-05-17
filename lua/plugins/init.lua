return {
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
    event = "BufReadPost",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = true,
  },

  -- Install a plugin
  -- 在插入模式下输入时不会有延迟地转义
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
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
    opts = {
      highlight = { timer = 250 },
      ring = { storage = "shada" },
    },
  },

  -- todo
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope" },
    config = true,
  },

  -- symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
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

  {
    "stevearc/dressing.nvim",
    event = "BufReadPost",
  },

  -- 重命名
  {
    "smjonas/inc-rename.nvim",
    event = "BufReadPost",
    config = function()
      require("inc_rename").setup()
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

  -- 使用ascii码来查看图片
  {
    "samodostal/image.nvim",
    event = "BufReadPost",
    dependencies = {
      -- 默认情况下颜色不打开的原因是打开图像时的显着延迟 使用该插件配套
      {
        "m00qek/baleia.nvim",
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
    "ggandor/leap.nvim",
    event = "VimEnter",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
      -- opts.sources[#opts.sources + 1] = { name = "codeium", group_index = 2, priority = 1000 }
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item()
      opts.mapping["<C-j>"] = cmp.mapping.select_next_item()
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
      "ahmedkhalf/project.nvim",
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
    end,
  },

  {
    "williamboman/mason.nvim",
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
        "vetur-vls",
        "vim-language-server",
        "vue-language-server",
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
