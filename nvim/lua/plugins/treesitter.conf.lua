local T = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
}

function T.config()
	require("nvim-treesitter.config").setup({
		highlight = {
			enable = true
		},
		indent = {
			enable = true
		}
	})
end

return T
