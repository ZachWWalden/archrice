return	{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "c_sharp", "bash", "cpp", "java", "latex", "markdown", "make", "python", "verilog", "vim" },
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
			vim.keymap.set('n', '<leader>vast', "<cmd>InspectTree<CR>")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}
