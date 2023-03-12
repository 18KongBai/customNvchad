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
    config = function()
    end,                     -- Override to setup mason-lspconfig
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
    event = "VimEnter",
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
    event = "VimEnter",
    init = require("core.utils").load_mappings "todo",
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
    opts = function()
      return require "custom.configs.image"
    end,
    config = function(_, opts)
      require("image").setup(opts)
    end,
  },

  -- 默认情况下颜色不打开的原因是打开图像时的显着延迟 使用该插件配套
  {
    "m00qek/baleia.nvim",
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

  -- 项目管理插件
  {
    "ahmedkhalf/project.nvim",
    event = "VimEnter",
    opts = function()
      return require "custom.configs.project"
    end,
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },

  -- 光标跳转插件
  {
    "ggandor/leap.nvim",
    event = "VimEnter",
    init = require("core.utils").load_mappings "leap",
    config = function()
      require("leap").add_default_mappings();
    end,
  },

  {
    "ggandor/flit.nvim",
    key = { "f" },
    config = true,
  },

  -- jsx 注释
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VimEnter",
  },

  -- lspsage 增加lsp功能
  {
    "glepnir/lspsaga.nvim",
    event = "VimEnter",
    config = true,
  },

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
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "numToStr/Comment.nvim",
    opts = overrides.comment,
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
  -- {
  --   "folke/which-key.nvim",
  --   enabled = true,
  -- },
}

return plugins
