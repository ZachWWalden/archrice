return	{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust", "c_sharp", "bash", "cpp", "java", "latex", "markdown", "make", "python", "verilog", "vim" },
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}

