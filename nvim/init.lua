-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--
-- basic setting
require('base')

--Plugin list
require("lazy").setup({

 -- Common Plugin(Lua)
  'nvim-lua/plenary.nvim',

  {'nvim-tree/nvim-web-devicons',lazy = false,priority = 1000},

 -- onedarkpro
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },

 -- Statusline
  {'nvim-lualine/lualine.nvim'},

 -- Buffer Control
  {'romgrk/barbar.nvim',dependencies = { 'nvim-web-devicons' }},

  {'lambdalisue/fern.vim',lazy = false, priority = 1000 }, --遅延読み込みをオフにして優先度を上げないとnvim-web-deviconsが読み込めない
  {'lambdalisue/glyph-palette.vim'},
  {'TheLeoP/fern-renderer-web-devicons.nvim',dependencies = {'nvim-web-devicons'}},


 --Syntax Highlight
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'JoosepAlviste/nvim-ts-context-commentstring'}, -- context-comment with treesitter
  {"yioneko/nvim-yati", version="*"},

  {'digitaltoad/vim-pug'}, -- for .jade,.pug file syntax

 -- Telescope
  {'nvim-telescope/telescope.nvim' },
  -- {'fannheyward/telescope-coc.nvim'},
  {
   "nvim-telescope/telescope-frecency.nvim",
  },

 -- Coding Support
  {'windwp/nvim-autopairs'},
  {'windwp/nvim-ts-autotag'},

  {'kevinhwang91/nvim-hlslens'},
  {'haya14busa/vim-asterisk'},
  {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  {'numToStr/Comment.nvim' },
  {'norcalli/nvim-colorizer.lua' },
  {"kylechui/nvim-surround"},

  {'simeji/winresizer' },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

 -- Rust Integration
 -- use 'rust-lang/rust.vim'

 -- For using Prettier
  {'prettier/vim-prettier'},

 -- Git Integration
  {'tpope/vim-fugitive'},
  {'lewis6991/gitsigns.nvim'},
  {'github/copilot.vim'},

 -- terminal Integration
  { 'akinsho/toggleterm.nvim'},

 -- skkeleton
  { 'vim-denops/denops.vim' },
  { 'vim-skk/skkeleton' },
  { 'delphinus/skkeleton_indicator.nvim' },

 -- vimtex
  -- {'lervag/vimtex'},

 -- rainbow parentheses
  {'HiPhish/nvim-ts-rainbow2'},

 -- vim-skim-synctex
  {'ryota2357/vim-skim-synctex'},

 -- vim-syntax-tyranoscript
  {"bellflower2015/vim-syntax-tyranoscript"},

 -- Bookmarks
  {
    'tomasky/bookmarks.nvim',
    -- after = "telescope.nvim",
    event = "VimEnter",
    config = function()
      require('bookmarks').setup()
    end
  },

  -- vim-edgemotion
   {'haya14busa/vim-edgemotion'},

  -- todo-comments
   {'folke/todo-comments.nvim'},

  -- lsp
  {'neovim/nvim-lspconfig'},

  -- mini.completion
  {'echasnovski/mini.completion'},

  -- telescope-media-files
  {'nvim-lua/popup.nvim'},
  {'nvim-lua/plenary.nvim'},
  {'nvim-telescope/telescope-media-files.nvim'},

  -- git-conflict
  {'akinsho/git-conflict.nvim', version = "*", config = true}
})

