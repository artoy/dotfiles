--vim-fugitiveとNeogitを併用

vim.cmd([[
nnoremap <silent> <space>gs :Git<CR><C-w>T
nnoremap <silent> <space>gb :Git blame<CR>
nnoremap <space>gd :Gvdiffsplit<CR>
nnoremap <silent> <space>gw :Gwrite<CR>
]])
-- nnoremap <silent> <space>l :Git log --graph<CR><C-w>T

-- neogit
-- local neogit = require('neogit')

-- neogit.setup {}
