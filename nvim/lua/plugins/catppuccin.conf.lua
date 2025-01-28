local C = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
}

function C.config()
    require('catppuccin').setup({
        flavour = 'macchiato',
    })
end

return C
