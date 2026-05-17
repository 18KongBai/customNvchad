return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  -- image.nvim 依赖 magick rock，强制使用 hererocks 自带 LuaJIT/luarocks，
  -- 避免系统 luarocks (Lua 5.5) 与 Neovim LuaJIT (5.1 ABI) 不兼容
  rocks = {
    hererocks = true,
  },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
