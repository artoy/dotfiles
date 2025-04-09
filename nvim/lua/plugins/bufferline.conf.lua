local B = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
}

function B.config()
    vim.opt.termguicolors = true
    require("bufferline").setup{}
end

return B;
