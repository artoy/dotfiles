local L = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    options = {
        theme = 'horizon',
    },
}

function L.config()
    require('lualine').setup({
        sections = {
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                    shorting_target = 40,
                    symbols = {
                        modified = '[+]',
                        readonly = '[Read Only]',
                        unnamed = '[No Name]',
                        newfile = '[New]',
                    }
                }
            }
        }
    })
end

return L
