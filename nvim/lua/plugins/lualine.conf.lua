local L = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    options = { theme = 'horizon' }
}

function L.config()
    require('lualine').setup()
end

return L
