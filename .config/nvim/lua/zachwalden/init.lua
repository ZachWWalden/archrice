require("zachwalden.lazy")
require("zachwalden.set")
require("zachwalden.remap")
require("zachwalden.colors")

local augroup = vim.api.nvim_create_augroup
local ZachWaldenGroup = augroup('ZachWalden', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove trailing whhitespace
autocmd({"BufWritePre"}, {
    group = ZachWaldenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd({"BufRead","BufNewFile"}, {
	group = ZachWaldenGroup,
	pattern = "*.tex",
	command = "set filetype=tex",
})

-- Runs a script that cleans out tex build files whenever I close out of a .tex file.
-- autocmd VimLeave *.tex !texclear %
autocmd({"VimLeave"},{
	group = ZachWaldenGroup,
	pattern = "*.tex",
	command = "!texclear %",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
