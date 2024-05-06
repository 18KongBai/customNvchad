local options = {
	mappings = {
		n = { ["q"] = require("telescope.actions").close },
		i = {
			-- move up and down
			["<C-j>"] = "move_selection_next",
			["<C-k>"] = "move_selection_previous",
			-- history
			["<Down>"] = "cycle_history_next",
			["<Up>"] = "cycle_history_prev",
			-- close window
			["<esc>"] = "close",
			["<C-u>"] = "preview_scrolling_up",
			["<C-d>"] = "preview_scrolling_down",
		},
	},
}

return options
