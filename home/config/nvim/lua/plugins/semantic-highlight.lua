return {
  {
    "jaxbot/semantic-highlight.vim",
    init = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end,
    ft = {'python', 'lua', 'java', 'nim', 'haskell', 'ruby', 'javascript'}
  }
}

