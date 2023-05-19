return {
  {
    "ntpeters/vim-better-whitespace",
    init = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  }
}
