local M = {}

M.treesitter = {
  -- :TSInstallInfo 命令查看支持的语言
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
    "mardown_inline",
    "vue",
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
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
    "vue-language-server"
  },
}

M.comment = {
  -- 使用ts_context_commentstring 进行注释jsx文件
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  view = {
    width = 30,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.blankline = {
  filetype_exclude = { "dashboard" },
}

M.telescope = {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      -- find command (defaults to `fd`)
      find_cmd = "rg",
      -- stretch source image horizontally
      -- images are rendered as colourful block characters in the terminal (█)
      -- the width of the block is about 2.5 times smaller than its height.
      -- So we'll have to stretch the image horizontally a bit. 250% width should
      -- be a good out of the box value, but you can override this.
      image_stretch = 150,
    },
  },
  extensions_list = { "themes", "terms", "projects", "media_files" },
}

return M
