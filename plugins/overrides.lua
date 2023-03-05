local M = {}
local isOk, com = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

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
    "markdown_inline",
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
    "vue-language-server",
  },
}

M.comment = {
  -- 使用ts_context_commentstring 进行注释jsx文件
  pre_hook = isOk and com.create_pre_hook(),
}

-- git support in nvimtree
M.nvimtree = {
  on_attach = function(bufnr)
    local treeOk, api = pcall(require, "nvim-tree.api")
    if not treeOk then
      return
    end
    local opts = function(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set("n", "i", api.node.show_info_popup, opts "Info")
    vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "a", api.fs.create, opts "Create")
    vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
    vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
    vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
    vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
    vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
    vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
    vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
    vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
    vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
    vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
  end,
  git = {
    enable = true,
    ignore = false,
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
