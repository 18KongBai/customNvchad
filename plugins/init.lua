local overrides = require "custom.plugins.overrides"

return {

  -- ["goolord/alpha-nvim"] = { disable = false },
  ["glepnir/dashboard-nvim"] = {
    event = "VimEnter",
    config = function()
      require "custom.plugins.configs.dashboard"
    end,
  },

  -- markdown-preview 插件
  ["iamcco/markdown-preview.nvim"] = {
    setup = function()
      require("core.utils").load_mappings "markdown"
    end,
  },
  -- kanagawa颜色主题插件
  ["rebelot/kanagawa.nvim"] = {},

  ["samodostal/image.nvim"] = {
    config = function()
      require "custom.plugins.configs.image"
    end,
  },
  ["m00qek/baleia.nvim"] = {},

  -- git显示历史提交记录
  ["APZelos/blamer.nvim"] = {
    setup = function()
      require("core.utils").load_mappings "blamer"
    end,
  },

  -- git插件管理
  ["kdheepak/lazygit.nvim"] = {
    config = function()
      require "custom.plugins.configs.lazygit"
    end,
    setup = function()
      require("core.utils").load_mappings "lazygit"
    end,
  },
  -- 项目管理插件
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require "custom.plugins.configs.project"
    end,
  },
  -- 光标跳转插件
  ["ggandor/leap.nvim"] = {
    config = function()
      require "custom.plugins.configs.leap"
    end,
  },
  -- jsx 注释
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},
  -- lspsage 增加lsp功能
  ["glepnir/lspsaga.nvim"] = {
    branch = "main",
    config = function()
      require "custom.plugins.configs.lspsaga"
    end,
  },
  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldlevelstart = 99
    end,
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["nvim-tree/nvim-tree.lua"] = {
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
      require "custom.plugins.configs.null-ls"
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
