return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      -- jsx 注释
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  {
    "rcarriga/nvim-notify",
    init = function()
      vim.notify = require "notify"
    end,
  },

  {
    "utilyre/barbecue.nvim",
    event = "BufReadPost",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = true
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
    event = "VimEnter",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        opts = function()
          local builtin = require "statuscol.builtin"
          return {
            setopt = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" },             click = "v:lua.ScSa" },
              {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
              },
            },
          }
        end,
      },
    },
    init = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    opts = function()
      return require "configs.nvim-ufo"
    end,
    config = function(_, opts)
      require("ufo").setup(opts)
    end,
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

  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "custom.configs.copilot-options"
  --   end,
  --   config = function(_, opts)
  --     require("copilot").setup(opts)
  --   end,
  -- },

  -- todo
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope" },
    config = true,
  },

  -- 代码预览图
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    config = function()
      require("rayso").setup {}
    end,
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
      return require "configs.image"
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
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    build = ":Codeium Auth",
    opts = {},
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   opts = function()
  --     return require "configs.copilot-options"
  --   end,
  --   config = function(_, opts)
  --     require("copilot").setup(opts)
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
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
        "json",
        "html",
        "css",
        "vim",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
        "vue",
      },
    },
  },
}
