local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
	-- {"nvim-treesitter/playground"} DEPRECATED, features built into neovim
	{
		"github/copilot.vim",
	},

	-- Zach's Plugins
	{
		"tpope/vim-commentary",
	},
	{
		"ap/vim-css-color",
	},
	{
		"ryanoasis/vim-devicons",
	},
	{
		"Yggdroot/indentLine",
	},
	--use("airblade/vimrooter")

	-- use("vimwiki/vimwiki")
}, {
	root = root .. "/plugins",
})
