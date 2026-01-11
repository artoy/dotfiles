local T = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'delphinus/telescope-memo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
}

function T.config()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    -- for telescope-memo
    require'telescope'.load_extension'memo'
    vim.keymap.set("n", "<leader>ml", ":Telescope memo list<CR>")
    vim.keymap.set("n", "<leader>mg", ":Telescope memo live_grep<CR>")

    -- for bookmarks
    require('telescope').load_extension('bookmarks')
    vim.keymap.set("n", "ml", ":Telescope bookmarks list<CR>")
end

return T
