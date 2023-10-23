return {
  "junegunn/fzf",
  {
    "junegunn/fzf.vim",
    config = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  }
}
