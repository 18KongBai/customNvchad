local overrides = require "custom.plugins.overrides"

return {

  -- ["goolord/alpha-nvim"] = { disable = false },
  ["glepnir/dashboard-nvim"] = {
    event = 'VimEnter',
    config = function()
      require "custom.plugins.dashboard"
    end,
    requires = {'nvim-tree/nvim-web-devicons'}
  },
  -- 透明插件
  ["xiyaowong/nvim-transparent"] = {},
  -- chatGPT
  --[[ ["jackMort/ChatGPT.nvim"] = {
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  }, ]]
  -- kanagawa颜色主题插件
  ["rebelot/kanagawa.nvim"] = {
    config = function()
      require "custom.plugins.transparent"
    end,
  },
  ["samodostal/image.nvim"] = {
    config = function()
      require "custom.plugins.image"
    end,
  },
  ["m00qek/baleia.nvim"] = {},
  -- git显示历史提交记录
  ["APZelos/blamer.nvim"] = {
    setup = function()
      require("core.utils").load_mappings "blamer"
    end,
  },
  ["nvim-lua/popup.nvim"] = {},
  -- 使用 Telescope 从 Neovim 预览图像、pdf、epub、视频和字体
  -- ["nvim-telescope/telescope-media-files.nvim"] = {},
  ["HendrikPetertje/telescope-media-files.nvim"] = {
    branch = "fix-replace-ueber-with-viu",
  },
  -- git插件管理
  ["kdheepak/lazygit.nvim"] = {
    config = function()
      require "custom.plugins.lazygit"
    end,
    setup = function()
      require("core.utils").load_mappings "lazygit"
    end,
  },
  -- 项目管理插件
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require "custom.plugins.project"
    end,
  },
  -- 光标跳转插件
  ["ggandor/leap.nvim"] = {
    config = function()
      require "custom.plugins.leap"
    end,
  },
  -- jsx 注释
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},
  -- lspsage 增加lsp功能
  ["glepnir/lspsaga.nvim"] = {
    branch = "main",
    config = function()
      require "custom.plugins.lspsaga"
    end,
    requires = { {"nvim-tree/nvim-web-devicons"} }
  },
  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },

  -- Install a plugin
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["numToStr/Comment.nvim"] = {
    override_options = overrides.comment,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = overrides.blankline,
  },

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}