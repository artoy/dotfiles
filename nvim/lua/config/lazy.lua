-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local lazycommit = "306a05526ada86a7b30af95c5cc81ffba93fef97"
local uv = vim.uv or vim.loop

local function bootstrap_error(message, detail)
  vim.api.nvim_echo({
    { message .. "\n", "ErrorMsg" },
    { detail or "", "WarningMsg" },
  }, true, {})
  if #vim.api.nvim_list_uis() > 0 then
    vim.fn.getchar()
  end
  os.exit(1)
end

local lazystat = uv.fs_lstat(lazypath)
if not lazystat then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--no-checkout", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    bootstrap_error("Failed to clone lazy.nvim:", out)
  end

  out = vim.fn.system({ "git", "-C", lazypath, "checkout", "--detach", lazycommit })
  if vim.v.shell_error ~= 0 then
    bootstrap_error("Failed to check out the pinned lazy.nvim revision:", out)
  end
elseif lazystat.type ~= "directory" then
  bootstrap_error("Refusing non-directory lazy.nvim path:", lazypath)
end

local lazyhead = vim.trim(vim.fn.system({ "git", "-C", lazypath, "rev-parse", "HEAD" }))
if vim.v.shell_error ~= 0 or lazyhead ~= lazycommit then
  bootstrap_error("lazy.nvim is not at the pinned revision:", lazyhead)
end

local lazystatus = vim.fn.system({ "git", "-C", lazypath, "status", "--porcelain", "--untracked-files=all" })
if vim.v.shell_error ~= 0 or lazystatus ~= "" then
  bootstrap_error("Refusing a modified lazy.nvim checkout:", lazystatus)
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = true },
})
