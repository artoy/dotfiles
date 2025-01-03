local L = {
	"nvim-lspconfig"
}

function L.config()
    require('lspconfig').typos_lsp.setup({
    init_options = {
            config = '~/.config/nvim/spell/.typos.toml',
        },
    })
end

return L
