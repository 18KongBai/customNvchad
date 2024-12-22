local actions = require "telescope.actions"
local options = {
  mappings = {
    n = { ["q"] = actions.close },
    i = {
      -- move up and down
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      -- history
      ["<Down>"] = actions.cycle_history_next,
      ["<Up>"] = actions.cycle_history_prev,
      -- close window
      ["<esc>"] = actions.close,
      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,
    },
  },
}

return options
