return	{
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	config = function ()
		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>pl', builtin.planets, {})
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("cWORD")
			builtin.grep_string({ search = word})
		end)
		vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

		-- You dont need to set any of these options. These are the default ones. Only
		-- the loading is important
		require('telescope').setup {
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
													 -- the default case_mode is "smart_case"
				}
			}
		}
		-- To get fzf loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require('telescope').load_extension('fzf')
	end
}


