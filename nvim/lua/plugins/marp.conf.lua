local M = {
    "nwiizo/marp.nvim",
    ft = "markdown",
}

function M.config()
    local theme_basic = vim.fn.expand("~/git/marp-themes/basic.css")
    require("marp").setup {
        -- Optional configuration
        marp_command = "/opt/homebrew/opt/node/bin/node /opt/homebrew/bin/marp",
        browser = nil, -- auto-detect
        server_mode = false, -- Use watch mode (-w)
        themes = {
            basic = theme_basic,
        },
    }
end

return M
