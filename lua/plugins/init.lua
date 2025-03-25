return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPost",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = function()
      return require "configs.avanteConfig"
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
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
    version = "v1.0.0",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
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
    -- opts = {
    --   highlight = { timer = 250 },
    --   ring = { storage = "shada" },
    -- },
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
    version = "4.4.7",
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

  -- codeium 代码提示
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      cmp.event:on("menu_opened", function()
        vim.g.codeium_manual = true
        vim.fn["codeium#Clear"]()
      end)
      cmp.event:on("menu_closed", function()
        vim.g.codeium_manual = false
        vim.fn["codeium#Complete"]()
      end)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })

      local mymappings = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end, { "i", "c" }),
      }

      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, mymappings)
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
