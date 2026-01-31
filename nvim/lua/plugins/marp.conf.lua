local M = {
    "nwiizo/marp.nvim",
    ft = "markdown",
}

function M.config()
    require("marp").setup {
      -- Optional configuration
      marp_command = "/opt/homebrew/opt/node/bin/node /opt/homebrew/bin/marp",
      browser = nil, -- auto-detect
      server_mode = false, -- Use watch mode (-w)
    }
end

return M
