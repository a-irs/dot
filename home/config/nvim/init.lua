vim.cmd [[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]]

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  -- no auto-reload on config change
  change_detection = {
    enabled = false,
  },
  ui = {
    icons = {
      -- unicode instead of nerdfont
      cmd = "⌘", config = "🛠", event = "📅", ft = "📂", init = "⚙", keys = "🗝", plugin = "🔌", runtime = "💻", source = "📄", start = "🚀", lazy = "💤 ",
    },
  },
}

-- load plugins from ./lua/plugins
require("lazy").setup("plugins", opts)
