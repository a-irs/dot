return {
  {
    "mhinz/vim-signify",
    init = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  },

  -- for staging hunk mapping
  "airblade/vim-gitgutter",

  -- verbose git commit message
  "rhysd/committia.vim"
}

