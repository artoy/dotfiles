require("config.lazy")
require("base")

-- **************************
-- postprocess
-- **************************
require('lualine').setup()
vim.cmd([[colorscheme catppuccin]])

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.ts_ls.setup{}

require("lspconfig").gopls.setup({
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true
			}
		}
	}
})

require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}
