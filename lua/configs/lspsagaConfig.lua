local options = {
  scroll_preview = {
    scroll_down = "<C-j>",
    scroll_up = "<C-k>",
  },
  diagnostic = {
    show_code_action = true,
    max_height = 0.8,
    keys = {
      exec_action = "o",
      quit = { "q", "<ESC>" },
    },
  },
}

return options
