local M = {
    "nwiizo/marp.nvim",
    ft = "markdown",
}

local function with_theme_set(cmd, files)
    if not files or #files == 0 then
        return cmd
    end
    local args = {}
    for _, path in ipairs(files) do
        local expanded = vim.fn.expand(path)
        table.insert(args, "--theme-set " .. expanded)
    end
    return cmd .. " " .. table.concat(args, " ")
end

function M.config()
    local theme_files = {
        "~/git/marp-themes/basic.css",
        -- Add more theme files here
        -- "~/git/marp-themes/pastel.css",
    }

    local themes = {
        basic = vim.fn.expand(theme_files[1]),
        -- pastel = vim.fn.expand(theme_files[2]),
    }

    require("marp").setup {
        -- Optional configuration
        marp_command = with_theme_set(
            "/opt/homebrew/opt/node/bin/node /opt/homebrew/bin/marp",
            theme_files
        ),
        browser = nil, -- auto-detect
        server_mode = false, -- Use watch mode (-w)
        themes = themes,
    }
end

return M
