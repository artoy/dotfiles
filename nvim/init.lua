require("config.lazy")

-- base settings
require("base")

-- plugin settings
require('lualine').setup()

require('catppuccin').setup({
    flavour = "macchiato"
})
vim.cmd([[colorscheme catppuccin]])

