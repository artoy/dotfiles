local T = {
    "bellflower2015/vim-syntax-tyranoscript"
}

function T.config()
    vim.filetype.add({
        extension = {
            ks = "tyranoscript",
        },
    })
end

return T
