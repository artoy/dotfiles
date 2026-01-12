local T = {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate'
}

function T.config()
	require("nvim-treesitter").setup({})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function(args)
			local bufnr = args.buf

            -- Skip not empty buffers
			if vim.bo[bufnr].buftype ~= "" then
				return
			end

			-- Only enable treesitter when a parser exists
			local ok = vim.treesitter.get_parser(bufnr, nil, { error = false }) ~= nil
			if not ok then
				return
			end

			vim.treesitter.start(bufnr)
			vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
end

return T
