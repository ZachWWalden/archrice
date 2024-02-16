vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

local colorGroup = vim.api.nvim_create_augroup('ColorGroup', {})

vim.api.nvim_create_autocmd({'BufRead','BufNewFile'}, {
    group = colorGroup,
    pattern = {'Xresources','Xdefaults','xresources','xdefaults'},
    callback = function()
        vim.opt.filetype = 'xdefaults'
    end,
})

vim.api.nvim_create_autocmd({'BufRead','BufNewFile'}, {
    group = colorGroup,
    pattern = {'Xresources','Xdefaults','xresources','xdefaults'},
    callback = function()
        vim.api.nvim_command([[!xrdb %]])
    end,
})
