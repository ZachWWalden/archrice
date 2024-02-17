return {
	{
		"vim-airline/vim-airline",
	},
	{
		"vim-airline/vim-airline-themes",
		dependencies = {
			"vim-airline/vim-airline",
			"ryanoasis/vim-devicons",
		},
		config = function ()
			vim.keymap.set("n", "<leader>at", ":AirlineTheme ")
			vim.g.airline_theme = "blood_red"
			vim.g.webdevicons_enable_airline_statusline = 1
			vim.g.webdevicons_enable_airline_tabline = 1
			-- vim.g.airline_powerline_fonts = 1
			-- vim.g.airline_left_sep = ''
			-- vim.g.airline_left_alt_sep = ''
			-- vim.g.airline_right_sep = ''
			-- vim.g.airline_right_alt_sep = ''
			-- vim.g.airline_symbols.branch = ''
			-- vim.g.airline_symbols.readonly = ''
			-- vim.g.airline_symbols.linenr = ''
		end
	},
}
