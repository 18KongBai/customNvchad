local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- Install a plugin
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
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    opts = function()
      return require "custom.configs.ufo"
    end,
    config = function(_, opts)
      require("ufo").setup(opts)
    end,
    init = require("core.utils").load_mappings "ufo",
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      return require "custom.configs.dashboard"
    end,
    config = function(_, opts)
      require("dashboard").setup(opts)
    end,
  },

  -- 自动调整焦点分割/窗口的大小
  {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    config = function()
      require("focus").setup {
        excluded_filetypes = { "toggleterm" },
      }
    end,
  },

  -- {
  --   "Exafunction/codeium.nvim",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup {}
  --   end,
  -- },

  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.copilot-options"
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- todo
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    init = require("core.utils").load_mappings "todo",
    config = true,
  },

  -- kanagawa颜色主题插件
  {
    "rebelot/kanagawa.nvim",
  },

  -- 使用ascii码来查看图片
  {
    "samodostal/image.nvim",
    event = "VimEnter",
    dependencies = {
      -- 默认情况下颜色不打开的原因是打开图像时的显着延迟 使用该插件配套
      {
        "m00qek/baleia.nvim",
      },
    },
    opts = function()
      return require "custom.configs.image"
    end,
    config = function(_, opts)
      require("image").setup(opts)
    end,
  },

  -- git显示历史提交记录
  {
    "APZelos/blamer.nvim",
    cmd = { "BlamerToggle" },
    init = require("core.utils").load_mappings "blamer",
  },

  -- git插件管理
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    init = require("core.utils").load_mappings "lazygit",
  },

  -- 光标跳转插件
  {
    "ggandor/leap.nvim",
    event = "VimEnter",
    -- keys = {
    --   { "f", "<Plug>(leap-forward)", desc = "开启搜索" },
    -- },
    init = require("core.utils").load_mappings "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- lspsage 增加lsp功能
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   event = "LspAttach",
  --   config = function()
  --     require("lspsaga").setup {}
  --   end,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter", -- optional
  --     "nvim-tree/nvim-web-devicons", -- optional
  --   },
  -- },

  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-project.nvim" },
    opts = overrides.telescope,
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
}

return plugins
