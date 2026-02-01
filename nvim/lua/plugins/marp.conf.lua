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

local function build_theme_files(theme_dir)
    local dir = vim.fn.expand(theme_dir)
    local files = vim.fn.globpath(dir, "*.css", false, true)
    table.sort(files)
    return files
end

local function build_themes(files)
    local themes = {}
    for _, path in ipairs(files) do
        local name = vim.fn.fnamemodify(path, ":t:r")
        themes[name] = path
    end
    return themes
end

function M.config()
    -- Enable polling to watch for markdown file changes
    vim.env.CHOKIDAR_USEPOLLING = "1"
    vim.env.CHOKIDAR_INTERVAL = "300"
    local theme_dir = "~/git/marp-themes"
    local theme_files = build_theme_files(theme_dir)
    local themes = build_themes(theme_files)

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
