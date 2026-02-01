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

    vim.lsp.config("typos_lsp", {
        init_options = {
            config = vim.fn.getcwd() .. "/typos.toml",
        },
    })
    vim.lsp.enable("typos_lsp")

    vim.lsp.config("ts_ls", {
        capabilities = capabilities
    })

    vim.lsp.config("gopls", {
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true
                },
                staticcheck = true
            }
        },
        capabilities = capabilities
    })
    vim.lsp.enable("gopls")

    vim.lsp.config("rust_analyzer", {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true;
          }
        }
      },
      capabilities = capabilities
    })

    vim.lsp.config("ocamllsp", {
        capabilities = capabilities
    })
end

return L
