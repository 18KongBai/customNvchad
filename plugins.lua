local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "williamboman/mason.nvim",
        opts = overrides.mason,
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "custom.configs.lspconfig" -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() end, -- Override to setup mason-lspconfig
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
      },
    },
    opts = function()
      return require "custom.configs.chatgpt"
    end,
    config = true,
  },

  {
    "glepnir/dashboard-nvim",
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
    "beauwilliams/focus.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.focus"
    end,
    config = function(_, opts)
      require("focus").setup(opts)
    end,
  },

  -- todo
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    init = require("core.utils").load_mappings "todo",
    config = true,
  },

  -- 撤销记录
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    init = require("core.utils").load_mappings "undotree",
  },

  -- markdown-preview 插件
  {
    "iamcco/markdown-preview.nvim",
    init = require("core.utils").load_mappings "markdown",
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

  -- {
  --   "ggandor/flit.nvim",
  --   config = true,
  -- },

  -- lspsage 增加lsp功能
  {
    "glepnir/lspsaga.nvim",
    event = "VimEnter",
    config = true,
  },

  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
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
    -- opts = overrides.comment,
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   opts = overrides.blankline,
  -- },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Uncomment if you want to re-enable which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
  },
}

return plugins
