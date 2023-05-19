return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      local rc = debug.getinfo(1).source:sub(2):gsub("%.lua", ".vim")
      vim.cmd("source " .. rc)
    end
  }
}
