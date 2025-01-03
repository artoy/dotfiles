local T = {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'delphinus/telescope-memo.nvim',
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
    vim.g.memoist_path = "~/.memolist/memo"
    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_fzf = 1
    vim.g.memolist_template_dir_path = "~/.memolist/memotemplates"

    vim.keymap.set("n", "<leader>ml", ":Telescope memo list<CR>")
    vim.keymap.set("n", "<leader>mg", ":Telescope memo live_grep<CR>")
end

return T
