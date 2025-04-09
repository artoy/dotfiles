-- leader key
vim.g.mapleader = ' '

local keymap = vim.keymap

-- buffer
keymap.set("n", "bd", ":bd<Return>")
keymap.set("n", "<tab>", ":bnext<Return>", opts)
keymap.set("n", "<s-tab>", ":bprevious<Return>", opts)

-- terminal
keymap.set("n", "<Leader>t", ":terminal<Return>")

-- splitting window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- moving between window
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')

-- maps to jj to Esc
keymap.set('i','jj','<Esc>')

-- for save and quit
keymap.set('n','<Leader>w',':w<CR>')
keymap.set('n','<Leader>q',':q<CR>')

-- open setting file
keymap.set('n','<F1>',':edit $MYVIMRC<CR>')

-- for moving on editor
keymap.set('n', '<Leader>l', '$')
keymap.set('v', '<Leader>l', '$')
keymap.set('n', '<Leader>h', '0')
keymap.set('v', '<Leader>h', '0')
keymap.set('n', '<Leader>j', '8j')
keymap.set('v', '<Leader>j', '8j')
keymap.set('n', '<Leader>k', '8k')
keymap.set('v', '<Leader>k', '8k')

-- move physical row instead of logical one
keymap.set('n','j','gj')
keymap.set('n','k','gk')

-- for escaping from terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true

-- parentheses settings
keymap.set('i','(','()<Left>')
keymap.set('i','{','{}<Left>')
keymap.set('i','[','[]<Left>')
keymap.set('i','"','""<Left>')
keymap.set('i',"'","''<Left>")

-- another settings
vim.opt.number = true
vim.opt.hls = true

