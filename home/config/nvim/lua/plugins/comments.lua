return {
  {
    "tpope/vim-commentary",
    config = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  }
}
