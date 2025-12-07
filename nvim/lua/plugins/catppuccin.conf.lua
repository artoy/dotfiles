local C = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
}

function C.config()
    require('catppuccin').setup({
        flavour = 'frappe',
    })

    vim.cmd([[colorscheme catppuccin]])
end

return C
