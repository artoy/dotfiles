local M = {
    "glidenote/memolist.vim"
}

function M.config()
    local keymap = vim.keymap
    keymap.set("n", "<leader>mn", ":MemoNew<CR>")
end

return M
