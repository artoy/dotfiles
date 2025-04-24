local M = {
    "glidenote/memolist.vim"
}

function M.config()
    vim.g.memolist_path = "~/memo"
    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_template_dir_path = "~/memo/memotemplates"
    vim.keymap.set("n", "<leader>mn", ":MemoNew<CR>")
end

return M
