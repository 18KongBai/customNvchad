-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}
M.ui = {
  theme = "nord",
  hl_override = {
    NvDashAscii = {
      fg = "blue",
      bg = "none",
    },

    NvDashButtons = {
      fg = "blue",
      bg = "none",
    },
  },
  transparency = false,

  nvdash = {
    load_on_startup = true,
    buttons = {
      { "  Find project", "Spc f p", "Telescope projects" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

return M
