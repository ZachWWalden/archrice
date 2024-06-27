return	{
	"Mofiqul/dracula.nvim",
	config = function ()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		local dracula = require("dracula")
		dracula.setup({
			-- customize dracula color palette
			-- show the '~' characters after the end of buffers
			show_end_of_buffer = true, -- default false
			-- use transparent background
			transparent_bg = true, -- default false
			-- set italic comment
			italic_comment = true, -- default false
		})
	end
}
