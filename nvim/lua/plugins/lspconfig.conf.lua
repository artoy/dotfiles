local L = {
	"nvim-lspconfig"
}

function L.config()
	require("lspconfig").gopls.setup({})
end

return L
