local L = {
	"nvim-lspconfig",
    lazy = true,
}

function L.config()
    -- カーソル下の変数の情報
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    -- 定義ジャンプ
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- 定義ジャンプ後に下のファイルに戻る
    vim.keymap.set('n', 'gt', '<C-t>')
    -- 改行やインデントなどのフォーマット
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    -- カーソル下の変数をコード内で参照している箇所
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- 変数名のリネーム
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig').typos_lsp.setup({
        init_options = {
            config = '~/.config/nvim/spell/.typos.toml',
        },
    })

    require'lspconfig'.ts_ls.setup{
        capabilities = capabilities
    }

    require("lspconfig").gopls.setup({
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true
                }
            }
        },
        capabilities = capabilities
    })

    require'lspconfig'.rust_analyzer.setup{
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false;
          }
        }
      },
      capabilities = capabilities
    }
end

return L
