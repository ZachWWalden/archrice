return	{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					'arduino',
					'asm',
					'bash',
					'c',
					'c_sharp',
					'cmake',
					'comment',
					'cpp',
					'css',
					'csv',
					'cuda',
					'devicetree',
					'diff',
					'disassembly',
					'dockerfile',
					'git_config',
					'git_rebase',
					'gitattributes',
					'gitcommit',
					'gitignore',
					'glsl',
					'go',
					'html',
					'http',
					'java',
					'javascript',
					'json',
					'kotlin',
					'make',
					'markdown',
					'matlab',
					'meson',
					'nix',
					'python',
					'regex',
					'rust',
					'sql',
					'ssh_config',
					'tcl',
					'typescript',
					'verilog',
					'vim',
					'vimdoc',
					'xml',
					'yaml',
					'zig'
				},
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

